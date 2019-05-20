//
//  StyleModel.h
//  Prisma
//
//  Created by Jiao Liu on 5/18/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
#import "SlimMPSCNN.h"
#import <Accelerate/Accelerate.h>

@interface StyleModel : NSObject
{
    id<MTLDevice> mtDevice;
    id<MTLCommandQueue> commandQueue;
    MPSCNNNeuronReLU *relu;
    MPSCNNNeuronSigmoid *sigmoid;
    SlimMPSCNN *contractConv1, *contractConv2, *contractConv3,
    *residual1Conv1, *residual1Conv2,
    *residual2Conv1, *residual2Conv2,
    *residual3Conv1, *residual3Conv2,
    *residual4Conv1, *residual4Conv2,
    *residual5Conv1, *residual5Conv2,
    *expandConv1, *expandConv2, *expandConv3;
//    MPSImage *cc1Image, *cc2Image, *cc3Image,
//    *rc11Image, *rc12Image,
//    *rc21Image, *rc22Image,
//    *rc31Image, *rc32Image,
//    *rc41Image, *rc42Image,
//    *rc51Image, *rc52Image,
//    *ec1Image, *ec2Image, *ec3Image;
    float *cc1Shift, *cc2Shift, *cc3Shift,
    *rc11Shift, *rc12Shift,
    *rc21Shift, *rc22Shift,
    *rc31Shift, *rc32Shift,
    *rc41Shift, *rc42Shift,
    *rc51Shift, *rc52Shift,
    *ec1Shift, *ec2Shift, *ec3Shift;
}

- (id)initWithDevice:(id<MTLDevice>)device commandQueue:(id<MTLCommandQueue>)queue;
- (void)setupNN;
- (MPSImage *)forward:(CGImageRef)srcImage width:(int)width height:(int)height styles:(float *)styles;

@end
