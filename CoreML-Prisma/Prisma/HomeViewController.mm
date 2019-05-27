//
//  HomeViewController.m
//  Prisma
//
//  Created by Jiao Liu on 4/21/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import "HomeViewController.h"
#import "stylize.h"

const int wanted_input_width = 512;
const int wanted_input_height = 512;
const int wanted_input_channels = 3;

API_AVAILABLE(ios(12.0))
@interface HomeViewController ()///<MTKViewDelegate>
{
    stylize *styleModel;
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
    if (@available(iOS 12.0, *)) {
        styleModel = [[stylize alloc] init];
    } else {
        NSLog(@"Need Run iOS 12.0+");
    }
}

- (IBAction)clearBtnClicked:(id)sender {
    _ogImageView.image = nil;
    _styleImageView.image = nil;
}

- (IBAction)styleBtnClicked:(id)sender {
    if (isDone) {
        _styleLabel.text = [NSString stringWithFormat:@"Style：%d", (int)[(UIStepper *)sender value]];
        currentStyle = (int)[(UIStepper *)sender value];
        if (_ogImageView.image != nil) {
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
        MLMultiArray *styleArray = [[MLMultiArray alloc] initWithShape:@[@32,@1,@1,@1,@1] dataType:MLMultiArrayDataTypeDouble error:nil];
        for (int i = 0; i < styleArray.count; i++) {
            [styleArray setObject:@0 atIndexedSubscript:i];
        }
        [styleArray setObject:@1 atIndexedSubscript:self->currentStyle];
        
        stylizeInput *input = [[stylizeInput alloc] initWithStyle__0:styleArray input__0:[self getImagePixel:source]];
        stylizeOutput *output = [styleModel predictionFromFeatures:input error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            self->_styleImageView.image = [self createImage:output.transformer__expand__conv3__conv__Sigmoid__0];
            self->isDone = true;
        });
    });
}

//- (CVPixelBufferRef)getImagePixel:(CGImageRef)image
//{
//    NSDictionary *options = @{
//                              (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
//                              (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
//                              (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
//                              };
//    CVPixelBufferRef pxbuffer = NULL;
//
//    CGFloat frameWidth = CGImageGetWidth(image);
//    CGFloat frameHeight = CGImageGetHeight(image);
//
//    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                          frameWidth,
//                                          frameHeight,
//                                          kCVPixelFormatType_32BGRA,
//                                          (__bridge CFDictionaryRef) options,
//                                          &pxbuffer);
//
//    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
//
//    CVPixelBufferLockBaseAddress(pxbuffer, 0);
//    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
//    NSParameterAssert(pxdata != NULL);
//
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//
//    CGContextRef context = CGBitmapContextCreate(pxdata,
//                                                 frameWidth,
//                                                 frameHeight,
//                                                 8,
//                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
//                                                 rgbColorSpace,
//                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
//    NSParameterAssert(context);
//    CGContextConcatCTM(context, CGAffineTransformIdentity);
//    CGContextDrawImage(context, CGRectMake(0,
//                                           0,
//                                           frameWidth,
//                                           frameHeight),
//                       image);
//    CGColorSpaceRelease(rgbColorSpace);
//    CGContextRelease(context);
//
//    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
//
//    return pxbuffer;
//}

- (MLMultiArray *)getImagePixel:(UIImage *)image
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
    MLMultiArray *tmpArray = [[MLMultiArray alloc] initWithShape:@[[NSNumber numberWithInt: wanted_input_channels],[NSNumber numberWithInt:wanted_input_height],[NSNumber numberWithInt:wanted_input_width]] dataType:MLMultiArrayDataTypeDouble error:nil];
    for (int y = 0; y < wanted_input_height; ++y) {
        for (int x = 0; x < wanted_input_width; ++x) {
            unsigned char *in_pixel =
            rawData + (y * wanted_input_width * bytesPerPixel) + (x * bytesPerPixel);
            for (int c = 0; c < wanted_input_channels; ++c) {
                [tmpArray setObject:[NSNumber numberWithUnsignedChar:in_pixel[c]] atIndexedSubscript:c*wanted_input_height*wanted_input_width+y*wanted_input_width+x];
            }
        }
    }
    free(rawData);
    return tmpArray;
}

- (UIImage *)createImage:(MLMultiArray *)pixels
API_AVAILABLE(ios(11.0)){
    unsigned char *rawData = (unsigned char*) calloc(wanted_input_height * wanted_input_width * 4, sizeof(unsigned char));
    for (int y = 0; y < wanted_input_height; ++y) {
        unsigned char *out_row = rawData + (y * wanted_input_width * 4);
        for (int x = 0; x < wanted_input_width; ++x) {
            int index = x * wanted_input_width + y;
            unsigned char *out_pixel = out_row + (x * 4);
            for (int c = 0; c < wanted_input_channels; ++c) {
                out_pixel[c] = [[pixels objectAtIndexedSubscript:c*wanted_input_height*wanted_input_width+index] floatValue] * 255;
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
