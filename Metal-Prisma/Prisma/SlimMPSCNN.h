//
//  SlimMPSCNN.h
//  Prisma
//
//  Created by Jiao Liu on 5/18/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>

@interface SlimMPSCNN : MPSCNNConvolution
{
    float *weights;
}

- (id)initWithDevice:(id<MTLDevice>)device kernelWidth:(NSUInteger)kernelWidth kernelHeight:(NSUInteger)kernelHeight strideInPixelsX:(NSUInteger)strideInPixelsX strideInPixelsY:(NSUInteger)strideInPixelsY inputFeatureChannels:(NSUInteger)inputFeatureChannels outputFeatureChannels:(NSUInteger)outputFeatureChannels neuronFilter:(MPSCNNNeuron *)neuronFilter kernelParamsBinaryName:(NSString *)kernelParamsBinaryName;
- (void)encodeToCommandBuffer:(id<MTLCommandBuffer>)commandBuffer sourceImage:(MPSImage *)sourceImage destinationImage:(MPSImage *)destinationImage device:(id<MTLDevice>)device;

@end
