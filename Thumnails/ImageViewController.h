//
//  ViewController.h
//  Thumnails
//
//  Created by Admin on 3/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *fullImageView;
@property (strong, nonatomic) UIImage *fullImage;
@property (strong, nonatomic) NSString *nameOfImage;

@end

