//
//  HomeViewController.m
//  Prisma
//
//  Created by Jiao Liu on 4/21/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import "HomeViewController.h"
#include "tensorflow_utils.h"

const std::string outputNode = "transformer/expand/conv3/conv/Sigmoid";
const std::string contentNode = "input";
const std::string styleNode = "style";
const int wanted_input_width = 512;
const int wanted_input_height = 512;
const int wanted_input_channels = 3;

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tensorflow::Status load_status;
    load_status = LoadModel(@"rounded_graph", @"pb", &tf_session);
    if (!load_status.ok()) {
        LOG(FATAL) << "Couldn't load model: " << load_status;
    }
    currentStyle = 0;
    isDone = true;
    _styleImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _styleImageView.layer.borderWidth = 0.5;
    _ogImageView.layer.borderColor = [UIColor grayColor].CGColor;
    _ogImageView.layer.borderWidth = 0.5;
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
            [self runCnn:_ogImageView.image];
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
        isDone = false;
//        dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
            UIImage *choosedImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
            CGSize sz = CGSizeMake(wanted_input_width, wanted_input_height);
            UIGraphicsBeginImageContext(sz);
            [choosedImage drawInRect:CGRectMake(0, 0, wanted_input_width, wanted_input_height)];
            UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [self runCnn:compressedImg];
//        });
    }];
}

- (void)runCnn:(UIImage *)compressedImg
{
    unsigned char *pixels = [self getImagePixel:compressedImg];
    int image_channels = 4;
    tensorflow::Tensor image_tensor(
                                    tensorflow::DT_FLOAT,
                                    tensorflow::TensorShape(
                                                            {1, wanted_input_height, wanted_input_width, wanted_input_channels}));
    auto image_tensor_mapped = image_tensor.tensor<float, 4>();
    tensorflow::uint8 *in = pixels;
    float *out = image_tensor_mapped.data();
    for (int y = 0; y < wanted_input_height; ++y) {
        float *out_row = out + (y * wanted_input_width * wanted_input_channels);
        for (int x = 0; x < wanted_input_width; ++x) {
            tensorflow::uint8 *in_pixel =
            in + (x * wanted_input_width * image_channels) + (y * image_channels);
            float *out_pixel = out_row + (x * wanted_input_channels);
            for (int c = 0; c < wanted_input_channels; ++c) {
                out_pixel[c] = in_pixel[c];
            }
        }
    }
    
    
    tensorflow::Tensor style(tensorflow::DT_FLOAT, tensorflow::TensorShape({32}));
    float *style_data = style.tensor<float, 1>().data();
    memset(style_data, 0, sizeof(float) * 32);
    style_data[currentStyle] = 1;
    
    if (tf_session.get()) {
        std::vector<tensorflow::Tensor> outputs;
        tensorflow::Status run_status = tf_session->Run(
                                                        {{contentNode, image_tensor},
                                                            {styleNode, style}},
                                                        {outputNode},
                                                        {},
                                                        &outputs);
        if (!run_status.ok()) {
            LOG(ERROR) << "Running model failed:" << run_status;
            isDone = true;
            free(pixels);
        } else {
            float *styledData = outputs[0].tensor<float,4>().data();
            UIImage *styledImg = [self createImage:styledData];
            dispatch_async(dispatch_get_main_queue(), ^{
                _styleImageView.image = styledImg;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    isDone = true;
                    free(pixels);
                });
            });
        }
    }
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
    UIImage *ogImg = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    dispatch_async(dispatch_get_main_queue(), ^{
        _ogImageView.image = ogImg;
    });
    CGContextRelease(context);
    return rawData;
}

- (UIImage *)createImage:(float *)pixels
{
    unsigned char *rawData = (unsigned char*) calloc(wanted_input_height * wanted_input_width * 4, sizeof(unsigned char));
    for (int y = 0; y < wanted_input_height; ++y) {
        unsigned char *out_row = rawData + (y * wanted_input_width * 4);
        for (int x = 0; x < wanted_input_width; ++x) {
            float *in_pixel =
            pixels + (x * wanted_input_width * 3) + (y * 3);
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
    return retImg;
}

@end
