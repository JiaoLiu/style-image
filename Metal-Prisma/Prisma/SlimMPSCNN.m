//
//  SlimMPSCNN.m
//  Prisma
//
//  Created by Jiao Liu on 5/18/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import "SlimMPSCNN.h"
#import <Accelerate/Accelerate.h>

@implementation SlimMPSCNN

- (id)initWithDevice:(id<MTLDevice>)device kernelWidth:(NSUInteger)kernelWidth kernelHeight:(NSUInteger)kernelHeight strideInPixelsX:(NSUInteger)strideInPixelsX strideInPixelsY:(NSUInteger)strideInPixelsY inputFeatureChannels:(NSUInteger)inputFeatureChannels outputFeatureChannels:(NSUInteger)outputFeatureChannels neuronFilter:(MPSCNNNeuron *)neuronFilter kernelParamsBinaryName:(NSString *)kernelParamsBinaryName
{
    NSString *wtPath = [[NSBundle mainBundle] pathForResource:kernelParamsBinaryName ofType:nil];
    if (![[NSFileManager defaultManager] fileExistsAtPath:wtPath]) {
        NSLog(@"%@ Not exist", wtPath);
    }
    NSData *wtData = [NSData dataWithContentsOfFile:wtPath];
    NSUInteger len =  kernelHeight * kernelWidth * inputFeatureChannels * outputFeatureChannels;
    weights = calloc(len, sizeof(float));
    [wtData getBytes:weights length:len*4];
//    if ([kernelParamsBinaryName isEqualToString:@"transformer_contract_conv1_weights"]) {
//            for (int i = 0; i < len; i++) {
//                printf("%f ",weights[i]);
//            }
//            NSLog(@"%@",wtPath);
//    }
//    for (int i = 0; i < len; i++) {
//        printf("%f ",weights[i]);
//    }
//    NSLog(@"%@",wtPath);
    MPSCNNConvolutionDescriptor *convDesc = [MPSCNNConvolutionDescriptor cnnConvolutionDescriptorWithKernelWidth:kernelWidth kernelHeight:kernelHeight inputFeatureChannels:inputFeatureChannels outputFeatureChannels:outputFeatureChannels neuronFilter:neuronFilter];
    convDesc.strideInPixelsX = strideInPixelsX;
    convDesc.strideInPixelsY = strideInPixelsY;
    self = [super initWithDevice:device convolutionDescriptor:convDesc kernelWeights:weights biasTerms:NULL flags:MPSCNNConvolutionFlagsNone];
//    self.edgeMode = MPSImageEdgeModeClamp;
    return self;
}

- (void)dealloc
{
    free(weights);
}

- (void)reflectPadding:(MPSImage *)source destinationImage:(MPSImage *)destinationImage
{
    NSUInteger w = source.texture.width;
    NSUInteger h = source.texture.height;
    NSUInteger w2 = destinationImage.texture.width;
    NSUInteger h2 = destinationImage.texture.height;
    NSUInteger featureNum = source.featureChannels;
    NSUInteger numSlices = (featureNum + 3) / 4;
    NSUInteger numComponents = featureNum < 3 ? featureNum : 4;
    NSUInteger channels = featureNum < 3 ? featureNum : numSlices * 4;
    float16_t *htemp1 = calloc(w*h*channels, sizeof(float16_t));
    float16_t *htemp2 = calloc(w2*h2*channels, sizeof(float16_t));
    for (int i = 0; i < numSlices; i++) {
        [source.texture getBytes:htemp1+w*h*numComponents*i bytesPerRow:w*numComponents*2 bytesPerImage:0 fromRegion:MTLRegionMake3D(0, 0, 0, w, h, 1) mipmapLevel:0 slice:i];
    }
    
    NSUInteger padw = (w2-w)/2;
    NSUInteger padh = (h2-h)/2;
    
    for (int k = 0; k < channels; k++) {
        int slice = k / 4;
        int stride = k % 4;
        // fill center
        for (int i = 0; i < h; i++) {
            for (int j = 0; j < w; j++) {
                htemp2[slice*w2*h2*numComponents+((i+padh)*w2+j+padw)*numComponents+stride] = htemp1[slice*w*h*numComponents+((i*w)+j)*numComponents+stride];
            }
        }
        
        // fill top
        for (int i = 0; i < padh; i++) {
            for (int j = 0; j < w; j++) {
                htemp2[slice*w2*h2*numComponents+(i*w2+j+padw)*numComponents+stride] = htemp2[slice*w2*h2*numComponents+((2*padh-i)*w2+j+padw)*numComponents+stride];
            }
        }
        
        // fill bot
        for (NSUInteger i = padh+h; i < h2; i++) {
            for (int j = 0; j < w; j++) {
                htemp2[slice*w2*h2*numComponents+(i*w2+j+padw)*numComponents+stride] = htemp2[slice*w2*h2*numComponents+((2*(padh+h-1)-i)*w2+j+padw)*numComponents+stride];
            }
        }
        
        // fill left
        for (int i = 0; i < h2; i++) {
            for (int j = 0; j < padw; j++) {
                htemp2[slice*w2*h2*numComponents+(i*w2+j)*numComponents+stride] = htemp2[slice*w2*h2*numComponents+(i*w2+2*padw-j)*numComponents+stride];
            }
        }
        
        // fill right
        for (int i = 0; i < h2; i++) {
            for (NSUInteger j = padw+w; j < w2; j++) {
                htemp2[slice*w2*h2*numComponents+(i*w2+j)*numComponents+stride] = htemp2[slice*w2*h2*numComponents+(i*w2+2*(padw+w-1)-j)*numComponents+stride];
            }
        }
    }
    
    for (int i = 0; i < numSlices; i++) {
        [destinationImage.texture replaceRegion:MTLRegionMake3D(0, 0, 0, w2, h2, 1) mipmapLevel:0 slice:i withBytes:htemp2+w2*h2*numComponents*i bytesPerRow:w2*numComponents*2 bytesPerImage:0];
    }
    free(htemp1);
    free(htemp2);
}

- (void)encodeToCommandBuffer:(id<MTLCommandBuffer>)commandBuffer sourceImage:(MPSImage *)sourceImage destinationImage:(MPSImage *)destinationImage device:(id<MTLDevice>)device
{
//    if (padding) {
        NSUInteger pad_along_height = ((destinationImage.height - 1) * self.strideInPixelsY + self.kernelHeight - sourceImage.height);
        NSUInteger pad_along_width  = ((destinationImage.width - 1) * self.strideInPixelsX + self.kernelWidth - sourceImage.width);
        NSUInteger pad_top = pad_along_height / 2;
        NSUInteger pad_left = pad_along_width / 2;
        MPSOffset newOff;
        newOff.x = self.kernelWidth/2 - pad_left;
        newOff.y = self.kernelHeight/2 - pad_top;
        newOff.z = 0;
        self.offset = newOff;
//    }
//    else
//    {
//        MPSOffset newOff;
//        newOff.x = self.kernelWidth/2;
//        newOff.y = self.kernelHeight/2;
//        newOff.z = 0;
//        self.offset = newOff;
//    }
//    NSUInteger padw = self.kernelWidth / 2;
//    NSUInteger padh = self.kernelHeight / 2;
//    MPSImageDescriptor *padDes = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:sourceImage.width+padw*2 height:sourceImage.height+padh*2 featureChannels:sourceImage.featureChannels];
//    MPSImage *padImage = [[MPSImage alloc] initWithDevice:device imageDescriptor:padDes];
//    [self reflectPadding:sourceImage destinationImage:padImage];
    [super encodeToCommandBuffer:commandBuffer sourceImage:sourceImage destinationImage:destinationImage];
}

@end
