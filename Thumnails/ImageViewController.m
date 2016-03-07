//
//  ViewController.m
//  Thumnails
//
//  Created by Admin on 3/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIGestureRecognizerDelegate>
@end

@implementation ImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftItemsSupplementBackButton = YES;
    [self.navigationItem.leftBarButtonItem setTitle:@"Choose image"];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector( scaleImage:)];
    [pinchGestureRecognizer setDelegate:self];
    pinchGestureRecognizer.scale = 1.0f;
    
    self.fullImageView.userInteractionEnabled = YES;
    [self.fullImageView addGestureRecognizer:pinchGestureRecognizer];
    self.fullImageView.contentMode = UIViewContentModeScaleAspectFill;
   
}

-(void)scaleImage:(UIPinchGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale, scale)];
        [recognizer setScale:1.0];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.fullImage)
    {
        self.fullImageView.image = self.fullImage;
        self.navigationItem.title = self.nameOfImage;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
