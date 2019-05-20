//
//  HomeViewController.m
//  Prisma
//
//  Created by Jiao Liu on 4/21/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import "HomeViewController.h"
#import "StyleModel.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <MetalPerformanceShaders/MetalPerformanceShaders.h>

const int wanted_input_width = 512;
const int wanted_input_height = 512;
const int wanted_input_channels = 3;

@interface HomeViewController ()///<MTKViewDelegate>
{
    id<MTLDevice> mtdevice;
    id<MTLCommandQueue> commandQueue;
//    id<MTLTexture> sourceTexture;
    MTKView *mtView;
    StyleModel *model;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentStyle = 0;
    isDone = true;
    _styleImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _styleImageView.layer.borderWidth = 0.5;
    _ogImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _ogImageView.layer.borderWidth = 0.5;
    
    [self setupMetal];
}

- (void)setupMetal
{
    mtdevice = MTLCreateSystemDefaultDevice();
    commandQueue = [mtdevice newCommandQueue];
    model = [[StyleModel alloc] initWithDevice:mtdevice commandQueue:commandQueue];
    [model setupNN];
//    mtView = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, wanted_input_width/2, wanted_input_height/2)];
//    mtView.center = _styleImageView.center;
//    mtView.framebufferOnly = NO;
//    mtView.paused = true;
//    mtView.delegate = self;
//    mtView.device = mtdevice;
//    mtView.colorPixelFormat = MTLPixelFormatRGBA16Float;
//    mtView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:mtView];
}

//- (void)drawInMTKView:(MTKView *)view
//{
//    id <CAMetalDrawable>currentDraw = mtView.currentDrawable;
//    id <MTLCommandBuffer>commandBuffer = [commandQueue commandBuffer];
//    id <MTLTexture> destinationTexture = currentDraw.texture;
//    [self filterImage:commandBuffer sourceTexture:sourceTexture destinationTexture:destinationTexture];
//    [commandBuffer presentDrawable:currentDraw];
//    [commandBuffer commit];
//    isDone = true;
//}
//
//- (void)filterImage:(id <MTLCommandBuffer>)buffer sourceTexture:(id <MTLTexture>)source destinationTexture:(id <MTLTexture>)destination
//{
//    id<MTLBlitCommandEncoder> blitCommandEncoder = [buffer blitCommandEncoder];
//    [blitCommandEncoder copyFromTexture:source sourceSlice:0 sourceLevel:0 sourceOrigin:MTLOriginMake(0, 0, 0) sourceSize:MTLSizeMake(source.width, source.height, 1) toTexture:destination destinationSlice:0 destinationLevel:0 destinationOrigin:MTLOriginMake(0, 0, 0)];
//    [blitCommandEncoder endEncoding];
//}
//
//- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size
//{
//    
//}

- (IBAction)clearBtnClicked:(id)sender {
    _ogImageView.image = nil;
    _styleImageView.image = nil;
}

- (IBAction)styleBtnClicked:(id)sender {
    if (isDone) {
        _styleLabel.text = [NSString stringWithFormat:@"Style：%d", (int)[(UIStepper *)sender value]];
        currentStyle = (int)[(UIStepper *)sender value];
        if (_ogImageView.image != nil) {
//            [self runCnn:_ogImageView.image];
            isDone = false;
            _styleImageView.image = nil;
            [self createStyleImage:_ogImageView.image];
        }
    }
}

- (IBAction)saveBtnClicked:(id)sender {
    if (isDone) {
        UIImageWriteToSavedPhotosAlbum(_styleImageView.image, nil, nil, nil);
    }
}

- (IBAction)PhotoClicked:(id)sender {
    if (isDone) {
        UIImagePickerController *libPicker = [[UIImagePickerController alloc] init];
        libPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        libPicker.allowsEditing = YES;
        libPicker.delegate = self;
        [self presentViewController:libPicker animated:YES completion:nil];
    }
}

- (IBAction)CameraClicked:(id)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"NO CAM!!");
        return;
    }
    if (isDone) {
        UIImagePickerController *camPicker = [[UIImagePickerController alloc] init];
        camPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        camPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        camPicker.allowsEditing = YES;
        camPicker.delegate = self;
        [self presentViewController:camPicker animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        picker.delegate = nil;
        self->isDone = false;
        //
        UIImage *choosedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        CGSize sz = CGSizeMake(wanted_input_width, wanted_input_height);
        UIGraphicsBeginImageContext(sz);
        [choosedImage drawInRect:CGRectMake(0, 0, wanted_input_width, wanted_input_height)];
        UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self->_ogImageView.image = compressedImg;
        self->_styleImageView.image = nil;
        [self createStyleImage:compressedImg];
    }];
}

- (void)createStyleImage:(UIImage *)source
{
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        float style[32];
        memset(style, 0, sizeof(style));
        style[self->currentStyle] = 1;
        id<MTLTexture> sourceTexture = [self->model forward:source.CGImage width:wanted_input_width height:wanted_input_height styles:&style[0]].texture;
        float16_t *temp = (float16_t *)calloc(wanted_input_width*wanted_input_height*4, sizeof(float16_t));
        [sourceTexture getBytes:temp bytesPerRow:wanted_input_height*4*2 fromRegion:MTLRegionMake3D(0, 0, 0, wanted_input_width, wanted_input_height, 1) mipmapLevel:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_styleImageView.image = [self createImage:temp];
            self->isDone = true;
        });
        //        [mtView draw];
    });
}

- (unsigned char *)getImagePixel:(UIImage *)image
{
    int width = image.size.width;
    int height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
    CGContextRotateCTM(context, M_PI_2);
    UIImage *ogImg = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_ogImageView.image = ogImg;
    });
    
    CGContextRelease(context);
    return rawData;
}

- (UIImage *)createImage:(float16_t *)pixels
{
    unsigned char *rawData = (unsigned char*) calloc(wanted_input_height * wanted_input_width * 4, sizeof(unsigned char));
    for (int y = 0; y < wanted_input_height; ++y) {
        unsigned char *out_row = rawData + (y * wanted_input_width * 4);
        for (int x = 0; x < wanted_input_width; ++x) {
            float16_t *in_pixel =
            pixels + (x * wanted_input_width * 4) + (y * 4);
            unsigned char *out_pixel = out_row + (x * 4);
            for (int c = 0; c < wanted_input_channels; ++c) {
                out_pixel[c] = in_pixel[c] * 255;
            }
            out_pixel[3] = UINT8_MAX;
        }
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * wanted_input_width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, wanted_input_width, wanted_input_height,
                                                 
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    UIImage *retImg = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    free(rawData);
    
    return [UIImage imageWithCGImage:retImg.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
}

@end
