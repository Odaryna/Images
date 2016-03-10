//
//  ImagesCellVC.h
//  Thumnails
//
//  Created by Admin on 3/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DownloadedImages <NSObject>

-(void)downloadImageForIndexPath:(NSIndexPath *)index;
-(void)progressOfDownloading:(float)progress atIndexPath:(NSIndexPath *)index;
-(void)downloadedImage:(UIImage *)image atIndexPath:(NSIndexPath *)index;
-(void)stopDownloadAtIndexPath:(NSIndexPath *)index;

@end

@interface ImagesCellVC : UITableViewCell <NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *imageName;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (strong, nonatomic) NSIndexPath *indexPathOfRow;
@property (weak, nonatomic) IBOutlet UILabel *progressPercents;

- (IBAction)downloadImage:(UIButton *)sender;

@property (weak, nonatomic) id<DownloadedImages> delegateDownload;

@end
