//
//  HomeViewController.h
//  Prisma
//
//  Created by Jiao Liu on 4/21/17.
//  Copyright © 2017 ChangHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int currentStyle;
    bool isDone;
}

@property (weak, nonatomic) IBOutlet UIImageView *ogImageView;
@property (weak, nonatomic) IBOutlet UIImageView *styleImageView;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;

@end
