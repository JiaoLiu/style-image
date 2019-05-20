//
//  HomeViewController.h
//  Prisma
//
//  Created by Jiao Liu on 4/21/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "tensorflow/core/public/session.h"
#include "tensorflow/core/util/memmapped_file_system.h"

@interface HomeViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    std::unique_ptr<tensorflow::Session> tf_session;
    int currentStyle;
    bool isDone;
}

@property (weak, nonatomic) IBOutlet UIImageView *ogImageView;
@property (weak, nonatomic) IBOutlet UIImageView *styleImageView;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;

@end
