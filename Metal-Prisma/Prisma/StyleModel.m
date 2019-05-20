//
//  StyleModel.m
//  Prisma
//
//  Created by Jiao Liu on 5/18/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import "StyleModel.h"

@implementation StyleModel

const int styleNum = 32;
const float epsilon = 1e-5;

- (id)initWithDevice:(id<MTLDevice>)device commandQueue:(id<MTLCommandQueue>)queue
{
    self = [super init];
    if (self) {
        mtDevice = device;
        commandQueue = queue;
    }
    return self;
}

- (void)setupNN
{
    if (mtDevice == nil) {
        mtDevice = MTLCreateSystemDefaultDevice();
    }
    if (commandQueue == nil) {
        commandQueue = [mtDevice newCommandQueue];
    }
    
    relu = [[MPSCNNNeuronReLU alloc] initWithDevice:mtDevice a:0];
    sigmoid = [[MPSCNNNeuronSigmoid alloc] initWithDevice:mtDevice];
    
    // contract
    contractConv1 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:9 kernelHeight:9 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:3 outputFeatureChannels:32 neuronFilter:nil kernelParamsBinaryName:@"transformer_contract_conv1_weights"];
    cc1Shift = [self loadShift:@"transformer_contract_conv1" featureNum:32];
    contractConv2 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:2 strideInPixelsY:2 inputFeatureChannels:32 outputFeatureChannels:64 neuronFilter:nil kernelParamsBinaryName:@"transformer_contract_conv2_weights"];
    cc2Shift = [self loadShift:@"transformer_contract_conv2" featureNum:64];
    contractConv3 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:2 strideInPixelsY:2 inputFeatureChannels:64 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_contract_conv3_weights"];
    cc3Shift = [self loadShift:@"transformer_contract_conv3" featureNum:128];
    
    // residual
    residual1Conv1 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual1_conv1_weights"];
    residual1Conv2 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual1_conv2_weights"];
    rc11Shift = [self loadShift:@"transformer_residual_residual1_conv1" featureNum:128];
    rc12Shift = [self loadShift:@"transformer_residual_residual1_conv2" featureNum:128];
    
    residual2Conv1 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual2_conv1_weights"];
    residual2Conv2 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual2_conv2_weights"];
    rc21Shift = [self loadShift:@"transformer_residual_residual2_conv1" featureNum:128];
    rc22Shift = [self loadShift:@"transformer_residual_residual2_conv2" featureNum:128];
    
    residual3Conv1 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual3_conv1_weights"];
    residual3Conv2 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual3_conv2_weights"];
    rc31Shift = [self loadShift:@"transformer_residual_residual3_conv1" featureNum:128];
    rc32Shift = [self loadShift:@"transformer_residual_residual3_conv2" featureNum:128];
    
    residual4Conv1 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual4_conv1_weights"];
    residual4Conv2 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual4_conv2_weights"];
    rc41Shift = [self loadShift:@"transformer_residual_residual4_conv1" featureNum:128];
    rc42Shift = [self loadShift:@"transformer_residual_residual4_conv2" featureNum:128];
    
    residual5Conv1 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual5_conv1_weights"];
    residual5Conv2 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:128 neuronFilter:nil kernelParamsBinaryName:@"transformer_residual_residual5_conv2_weights"];
    rc51Shift = [self loadShift:@"transformer_residual_residual5_conv1" featureNum:128];
    rc52Shift = [self loadShift:@"transformer_residual_residual5_conv2" featureNum:128];
    
    // expand
    expandConv1 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:128 outputFeatureChannels:64 neuronFilter:nil kernelParamsBinaryName:@"transformer_expand_conv1_conv_weights"];
    expandConv2 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:3 kernelHeight:3 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:64 outputFeatureChannels:32 neuronFilter:nil kernelParamsBinaryName:@"transformer_expand_conv2_conv_weights"];
    expandConv3 = [[SlimMPSCNN alloc] initWithDevice:mtDevice kernelWidth:9 kernelHeight:9 strideInPixelsX:1 strideInPixelsY:1 inputFeatureChannels:32 outputFeatureChannels:3 neuronFilter:nil kernelParamsBinaryName:@"transformer_expand_conv3_conv_weights"];
    ec1Shift = [self loadShift:@"transformer_expand_conv1_conv" featureNum:64];
    ec2Shift = [self loadShift:@"transformer_expand_conv2_conv" featureNum:32];
    ec3Shift = [self loadShift:@"transformer_expand_conv3_conv" featureNum:3];
}

- (float *)loadShift:(NSString *)path featureNum:(int)featureNum
{
    NSString *betaPath = [[NSBundle mainBundle] pathForResource:[path stringByAppendingString:@"_InstanceNorm_beta"] ofType:nil];
    if (![[NSFileManager defaultManager] fileExistsAtPath:betaPath]) {
        NSLog(@"%@ Not exist", betaPath);
    }
    NSData *betaData = [NSData dataWithContentsOfFile:betaPath];
    NSString *gammaPath = [[NSBundle mainBundle] pathForResource:[path stringByAppendingString:@"_InstanceNorm_gamma"] ofType:nil];
    if (![[NSFileManager defaultManager] fileExistsAtPath:gammaPath]) {
        NSLog(@"%@ Not exist", gammaPath);
    }
    NSData *gammaData = [NSData dataWithContentsOfFile:gammaPath];
    NSUInteger len = 2*styleNum*featureNum;
    float *temp = calloc(len, sizeof(float));
    [betaData getBytes:temp length:len/2 * 4];
    [gammaData getBytes:temp+len/2 length:len/2 * 4];
    
//    if ([path isEqualToString:@"transformer_residual_residual1_conv1"]) {
//            for (int i = 0; i < len; i++) {
//                printf("%f ",temp[i]);
//            }
//            NSLog(@"%@",path);
//    }
//    for (int i = 0; i < len; i++) {
//        printf("%f ",temp[i]);
//    }
//    NSLog(@"%@",path);
    return temp;
}

- (void)floatToHalf:(float *)floatp halfp:(float16_t *)halfp width:(NSUInteger)width height:(NSUInteger)height channel:(NSUInteger)channel
{
    vImage_Buffer halfb,fullb;
    halfb.data = halfp;
    halfb.height = height;
    halfb.width = width * channel;
    halfb.rowBytes = width * channel *2;
    fullb.data = floatp;
    fullb.height = height;
    fullb.width = width * channel;
    fullb.rowBytes = width * channel *4;
    vImageConvert_PlanarFtoPlanar16F(&fullb, &halfb, 0);
}

- (void)halfTofloat:(float16_t *)halfp floatp:(float *)floatp width:(NSUInteger)width height:(NSUInteger)height channel:(NSUInteger)channel
{
    vImage_Buffer halfb,fullb;
    halfb.data = halfp;
    halfb.height = height;
    halfb.width = width * channel;
    halfb.rowBytes = width * channel *2;
    fullb.data = floatp;
    fullb.height = height;
    fullb.width = width * channel;
    fullb.rowBytes = width * channel *4;
    vImageConvert_Planar16FtoPlanarF(&halfb, &fullb, 0);
}

- (void)batch_norm:(MPSImage *)image styles:(float *)styles shift:(float *)shift
{
    NSUInteger w = image.texture.width;
    NSUInteger h = image.texture.height;
    NSUInteger featureNum = image.featureChannels;
    float *gamma = calloc(featureNum, sizeof(float));
    float *beta = calloc(featureNum, sizeof(float));
//    float gamma[featureNum], beta[featureNum];
    vDSP_mmul(styles, 1, shift, 1, beta, 1, 1, featureNum, styleNum);
    vDSP_mmul(styles, 1, shift+featureNum*styleNum, 1, gamma, 1, 1, featureNum, styleNum);
//    for (int i = 0; i < featureNum; i++) {
//        printf("%f,%f ",gamma[i],beta[i]);
//    }
//    NSLog(@"%@",image);
//    
    NSUInteger numSlices = (featureNum + 3) / 4;
    NSUInteger numComponents = featureNum < 3 ? featureNum : 4;
    NSUInteger channels = featureNum < 3 ? featureNum : numSlices * 4;
    float16_t *htemp = calloc(w*h*channels, sizeof(float16_t));
    for (int i = 0; i < numSlices; i++) {
        [image.texture getBytes:htemp+w*h*numComponents*i bytesPerRow:w*numComponents*2 bytesPerImage:0 fromRegion:MTLRegionMake3D(0, 0, 0, w, h, 1) mipmapLevel:0 slice:i];
    }
    
    float *temp = calloc(w*h*channels, sizeof(float));
    [self halfTofloat:htemp floatp:temp width:w height:h channel:channels];
    float mean, var;
    for (int i = 0; i < featureNum; i++) {
        int slice = i / 4;
        int stride = i % 4;
//        for (int p = 0; p < w*h; p++) {
//            int index=slice*w*h*numComponents+stride;
//            if (temp[p*4+index] != temp[index]) {
//                printf("%f ",temp[p*4+index]);
//            }
//        }
        vDSP_normalize(temp+slice*w*h*numComponents+stride, numComponents, temp+slice*w*h*numComponents+stride, numComponents, &mean, &var, w*h);
        if (var == 0) {
            vDSP_vfill(&var, temp+slice*w*h*numComponents+stride, numComponents, w*h);
        }
        vDSP_vsmul(temp+slice*w*h*numComponents+stride, numComponents, &gamma[i], temp+slice*w*h*numComponents+stride, numComponents, w*h);
        vDSP_vsadd(temp+slice*w*h*numComponents+stride, numComponents, &beta[i], temp+slice*w*h*numComponents+stride, numComponents, w*h);
    }
    [self floatToHalf:temp halfp:htemp width:w height:h channel:channels];
    for (int i = 0; i < numSlices; i++) {
        [image.texture replaceRegion:MTLRegionMake3D(0, 0, 0, w, h, 1) mipmapLevel:0 slice:i withBytes:htemp+w*h*numComponents*i bytesPerRow:w*numComponents*2 bytesPerImage:0];
    }
    free(temp);
    free(htemp);
    free(gamma);
    free(beta);
}

- (void)addImage:(MPSImage *)A B:(MPSImage *)B C:(MPSImage *)C
{
    NSUInteger w = A.texture.width;
    NSUInteger h = A.texture.height;
    NSUInteger featureNum = A.featureChannels;
    NSUInteger numSlices = (featureNum + 3) / 4;
    NSUInteger numComponents = featureNum < 3 ? featureNum : 4;
    NSUInteger channels = featureNum < 3 ? featureNum : numSlices * 4;
    float16_t *htemp1 = calloc(w*h*channels, sizeof(float16_t));
    float16_t *htemp2 = calloc(w*h*channels, sizeof(float16_t));
    for (int i = 0; i < numSlices; i++) {
        [A.texture getBytes:htemp1+w*h*numComponents*i bytesPerRow:w*numComponents*2 bytesPerImage:0 fromRegion:MTLRegionMake3D(0, 0, 0, w, h, 1) mipmapLevel:0 slice:i];
        [B.texture getBytes:htemp2+w*h*numComponents*i bytesPerRow:w*numComponents*2 bytesPerImage:0 fromRegion:MTLRegionMake3D(0, 0, 0, w, h, 1) mipmapLevel:0 slice:i];
    }
    float *temp1 = calloc(w*h*channels, sizeof(float));
    float *temp2 = calloc(w*h*channels, sizeof(float));
    [self halfTofloat:htemp1 floatp:temp1 width:w height:h channel:channels];
    [self halfTofloat:htemp2 floatp:temp2 width:w height:h channel:channels];
    vDSP_vadd(temp1, 1, temp2, 1, temp2, 1, w*h*channels);
    [self floatToHalf:temp2 halfp:htemp2 width:w height:h channel:channels];
    for (int i = 0; i < numSlices; i++) {
        [C.texture replaceRegion:MTLRegionMake3D(0, 0, 0, w, h, 1) mipmapLevel:0 slice:i withBytes:htemp2+w*h*numComponents*i bytesPerRow:w*numComponents*2 bytesPerImage:0];
    }
    free(htemp1);
    free(htemp2);
    free(temp1);
    free(temp2);
}

- (void)ResizeNearestNeighbor:(MPSImage *)source destinationImage:(MPSImage *)destinationImage
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
    
    int x_ratio = (int)((w<<16)/w2) +1;
    int y_ratio = (int)((h<<16)/h2) +1;
    int x2, y2 ;
    
    for (int k = 0; k < featureNum; k++) {
        int slice = k / 4;
        int stride = k % 4;
        for (int i=0;i<h2;i++) {
            for (int j=0;j<w2;j++) {
                x2 = ((j*x_ratio)>>16) ;
                y2 = ((i*y_ratio)>>16) ;
                htemp2[slice*w2*h2*numComponents+(i*w2+j)*numComponents+stride] = htemp1[slice*w*h*numComponents+((y2*w)+x2)*numComponents+stride];
            }
        }
    }
    
    for (int i = 0; i < numSlices; i++) {
        [destinationImage.texture replaceRegion:MTLRegionMake3D(0, 0, 0, w2, h2, 1) mipmapLevel:0 slice:i withBytes:htemp2+w2*h2*numComponents*i bytesPerRow:w2*numComponents*2 bytesPerImage:0];
    }
    free(htemp1);
    free(htemp2);
}

- (MPSImage *)forward:(CGImageRef)srcImage width:(int)width height:(int)height styles:(float *)styles
{
    id<MTLCommandBuffer> commandbuffer = [commandQueue commandBuffer];
    int w = width;
    int h = height;
    MTKTextureLoader *loader = [[MTKTextureLoader alloc] initWithDevice:mtDevice];
    id<MTLTexture> srcTexture = [loader newTextureWithCGImage:srcImage options:nil error:nil];
    MPSImage *cc1Image = [[MPSImage alloc] initWithTexture:srcTexture featureChannels:3];
    
//    MPSImage *tImage = [[MPSImage alloc] initWithTexture:srcTexture featureChannels:3];
//    MPSImageDescriptor *cc1Des = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:3];
//    MPSImage *cc1Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:cc1Des];
//    [cc1Image.texture replaceRegion:MTLRegionMake3D(0, 0, 0, w, h, 1) mipmapLevel:0 withBytes:srcImage bytesPerRow:w*4*2];
    // contract
    MPSImageDescriptor *cc2Des = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:32];
    MPSImage *cc2Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:cc2Des];
    [contractConv1 encodeToCommandBuffer:commandbuffer sourceImage:cc1Image destinationImage:cc2Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:cc2Image styles:styles shift:cc1Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:cc2Image destinationImage:cc2Image];
    w /= 2;
    h /= 2;
    MPSImageDescriptor *cc3Des = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:64];
    MPSImage *cc3Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:cc3Des];
    [contractConv2 encodeToCommandBuffer:commandbuffer sourceImage:cc2Image destinationImage:cc3Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:cc3Image styles:styles shift:cc2Shift];

    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:cc3Image destinationImage:cc3Image];
    w /= 2;
    h /= 2;
    MPSImageDescriptor *rcDes = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:128];
    MPSImage *rc11Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [contractConv3 encodeToCommandBuffer:commandbuffer sourceImage:cc3Image destinationImage:rc11Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc11Image styles:styles shift:cc3Shift];
    
    // residual
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:rc11Image destinationImage:rc11Image];
    MPSImage *rc12Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual1Conv1 encodeToCommandBuffer:commandbuffer sourceImage:rc11Image destinationImage:rc12Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc12Image styles:styles shift:rc11Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:rc12Image destinationImage:rc12Image];
    MPSImage *rc21Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual1Conv2 encodeToCommandBuffer:commandbuffer sourceImage:rc12Image destinationImage:rc21Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc21Image styles:styles shift:rc12Shift];
    [self addImage:rc11Image B:rc21Image C:rc21Image];
    
    commandbuffer = [commandQueue commandBuffer];
    MPSImage *rc22Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual2Conv1 encodeToCommandBuffer:commandbuffer sourceImage:rc21Image destinationImage:rc22Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc22Image styles:styles shift:rc21Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:rc22Image destinationImage:rc22Image];
    MPSImage *rc31Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual2Conv2 encodeToCommandBuffer:commandbuffer sourceImage:rc22Image destinationImage:rc31Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc31Image styles:styles shift:rc22Shift];
    [self addImage:rc21Image B:rc31Image C:rc31Image];
    
    commandbuffer = [commandQueue commandBuffer];
    MPSImage *rc32Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual3Conv1 encodeToCommandBuffer:commandbuffer sourceImage:rc31Image destinationImage:rc32Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc32Image styles:styles shift:rc31Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:rc32Image destinationImage:rc32Image];
    MPSImage *rc41Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual3Conv2 encodeToCommandBuffer:commandbuffer sourceImage:rc32Image destinationImage:rc41Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc41Image styles:styles shift:rc32Shift];
    [self addImage:rc31Image B:rc41Image C:rc41Image];
    
    commandbuffer = [commandQueue commandBuffer];
    MPSImage *rc42Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual4Conv1 encodeToCommandBuffer:commandbuffer sourceImage:rc41Image destinationImage:rc42Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc42Image styles:styles shift:rc41Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:rc42Image destinationImage:rc42Image];
    MPSImage *rc51Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual4Conv2 encodeToCommandBuffer:commandbuffer sourceImage:rc42Image destinationImage:rc51Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc51Image styles:styles shift:rc42Shift];
    [self addImage:rc41Image B:rc51Image C:rc51Image];
    
    commandbuffer = [commandQueue commandBuffer];
    MPSImage *rc52Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual5Conv1 encodeToCommandBuffer:commandbuffer sourceImage:rc51Image destinationImage:rc52Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:rc52Image styles:styles shift:rc51Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:rc52Image destinationImage:rc52Image];
    MPSImage *temp = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:rcDes];
    [residual5Conv2 encodeToCommandBuffer:commandbuffer sourceImage:rc52Image destinationImage:temp device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:temp styles:styles shift:rc52Shift];
    [self addImage:rc51Image B:temp C:temp];
    
    // unsampling
    commandbuffer = [commandQueue commandBuffer];
    w *= 2;
    h *= 2;
    MPSImageDescriptor *ec1Des = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:128];
    MPSImage *ec1Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:ec1Des];
    [self ResizeNearestNeighbor:temp destinationImage:ec1Image];
    
    MPSImageDescriptor *temp2Des = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:64];
    MPSImage *temp2 = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:temp2Des];
    [expandConv1 encodeToCommandBuffer:commandbuffer sourceImage:ec1Image destinationImage:temp2 device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:temp2 styles:styles shift:ec1Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:temp2 destinationImage:temp2];
    w *= 2;
    h *= 2;
    MPSImageDescriptor *ec2Des = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:64];
    MPSImage *ec2Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:ec2Des];
    [self ResizeNearestNeighbor:temp2 destinationImage:ec2Image];
    
    MPSImageDescriptor *ec3Des = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:32];
    MPSImage *ec3Image = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:ec3Des];
    [expandConv2 encodeToCommandBuffer:commandbuffer sourceImage:ec2Image destinationImage:ec3Image device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:ec3Image styles:styles shift:ec2Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [relu encodeToCommandBuffer:commandbuffer sourceImage:ec3Image destinationImage:ec3Image];
    MPSImageDescriptor *destDes = [MPSImageDescriptor imageDescriptorWithChannelFormat:MPSImageFeatureChannelFormatFloat16 width:w height:h featureChannels:3];
    MPSImage *destImage = [[MPSImage alloc] initWithDevice:mtDevice imageDescriptor:destDes];
    [expandConv3 encodeToCommandBuffer:commandbuffer sourceImage:ec3Image destinationImage:destImage device:mtDevice];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    [self batch_norm:destImage styles:styles shift:ec3Shift];
    
    commandbuffer = [commandQueue commandBuffer];
    [sigmoid encodeToCommandBuffer:commandbuffer sourceImage:destImage destinationImage:destImage];
    [commandbuffer commit];
    [commandbuffer waitUntilCompleted];
    return destImage;
}

@end
