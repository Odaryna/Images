//
//  ImagesCellVC.m
//  Thumnails
//
//  Created by Admin on 3/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ImagesCellVC.h"
#import "ImagesUrls.h"

@interface ImagesCellVC ()

@property (nonatomic, strong) NSMutableData *imageData;

@end

@implementation ImagesCellVC

- (IBAction)downloadImage:(UIButton *)sender
{
    if (self.imageIsDownloading)
    {
        [self.progressPercents setText:@""];
        self.progressView.hidden = YES;
        self.imageIsDownloading = NO;
        [self.downloadButton setImage:[UIImage imageNamed:@"windows_7_download_library_ico_by_sdbinwiiexe-d3c9fb7.png"] forState:UIControlStateNormal];
        [self.downloadButton setTitle:@"" forState: UIControlStateNormal];
    }
    else
    {
        NSURL* url = [NSURL URLWithString:[[ImagesUrls sharedInstance] urlForImageByIndex:self.indexOfRow]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        
        self.progressView.hidden = NO;
        [self.progressView setProgress:0.0f];
        self.imageIsDownloading = YES;
        [self.downloadButton setImage:nil forState:UIControlStateNormal];
        [self.downloadButton setTitle:@"⬛️" forState: UIControlStateNormal];
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *dict = httpResponse.allHeaderFields;
    NSString *lengthString = [dict valueForKey:@"Content-Length"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *length = [formatter numberFromString:lengthString];
    self.totalBytes = length.unsignedIntegerValue;
    self.imageData = [[NSMutableData alloc] initWithCapacity:self.totalBytes];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (!self.imageIsDownloading)
    {
        [connection cancel];
        self.imageData = nil;
        self.receivedBytes = 0;
        return;
    }
    
    [self.imageData appendData:data];
    self.receivedBytes += data.length;
    
    float process = (float)self.receivedBytes/self.totalBytes;
    NSUInteger percents = (NSUInteger)(process*100.0f);
    NSString *strPercents = [NSString stringWithFormat:@"%lu",(unsigned long)percents];
    [self.progressPercents setText:[strPercents stringByAppendingString: @"%"]];
    [self.progressView setProgress:process animated:YES];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"downloaded_images"];
    if (!dict)
    {
        dict = [[NSDictionary alloc]init];
    }
  
    NSMutableDictionary *mutDict = [dict mutableCopy];
    [mutDict setObject:self.imageData forKey:[NSString stringWithFormat:@"%lu", (unsigned long)self.indexOfRow]];
    [[NSUserDefaults standardUserDefaults] setObject:mutDict forKey:@"downloaded_images"];
    
    UIImage *image = [UIImage imageWithData:self.imageData];
    self.imageIsDownloaded = YES;
    self.downloadButton.hidden = YES;
    [self.delegateDownload downloadedImage:image forKey:self.indexOfRow];
    self.progressView.hidden = YES;
    [self.progressPercents setText:@""];
    self.imageIsDownloading = NO;

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Not loaded image!");
}



@end
