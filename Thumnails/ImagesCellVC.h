//
//  ImagesCellVC.h
//  Thumnails
//
//  Created by Admin on 3/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DownloadedImages <NSObject>

-(void)downloadedImage:(UIImage *)image forKey:(NSUInteger)index;

@end

@interface ImagesCellVC : UITableViewCell <NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *imageName;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (assign, nonatomic) NSUInteger indexOfRow;
@property (assign, nonatomic) BOOL imageIsDownloaded;
@property (assign, nonatomic) BOOL imageIsDownloading;
@property (weak, nonatomic) IBOutlet UILabel *progressPercents;
@property (nonatomic, assign) NSUInteger totalBytes;
@property (nonatomic, assign) NSUInteger receivedBytes;

- (IBAction)downloadImage:(UIButton *)sender;

@property (weak, nonatomic) id<DownloadedImages> delegateDownload;

@end
