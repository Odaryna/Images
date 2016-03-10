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
@property (nonatomic, assign) NSUInteger totalBytes;
@property (nonatomic, assign) NSUInteger receivedBytes;

@end

@implementation ImagesCellVC

- (IBAction)downloadImage:(UIButton *)sender
{
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"⬛️"])
    {
        [self.progressPercents setText:@""];
        self.progressView.hidden = YES;
        [self.downloadButton setImage:[UIImage imageNamed:@"windows_7_download_library_ico_by_sdbinwiiexe-d3c9fb7.png"] forState:UIControlStateNormal];
        [self.downloadButton setTitle:@"" forState: UIControlStateNormal];
    }
    else
    {
        [self.delegateDownload downloadImageForIndexPath:self.indexPathOfRow];
        NSURL* url = [NSURL URLWithString:[[ImagesUrls sharedInstance] urlForImageByIndex:self.indexPathOfRow.row]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    }
    

}

#pragma mark - NSURLConnectionDataDelegate

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
    if ([[self.downloadButton titleForState:UIControlStateNormal] isEqualToString:@""])
    {
        [connection cancel];
        self.imageData = nil;
        self.receivedBytes = 0;
        [self.delegateDownload stopDownloadAtIndexPath:self.indexPathOfRow];
        return;
    }
    
    [self.imageData appendData:data];
    self.receivedBytes += data.length;
    
    float process = (float)self.receivedBytes/self.totalBytes;
    [self.delegateDownload progressOfDownloading:process atIndexPath:self.indexPathOfRow];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"downloaded_images"];
    if (!dict)
    {
        dict = [[NSDictionary alloc]init];
    }
    
    NSMutableDictionary *mutDict = [dict mutableCopy];
    [mutDict setObject:self.imageData forKey:[NSString stringWithFormat:@"%lu", (unsigned long)self.indexPathOfRow.row]];
    [[NSUserDefaults standardUserDefaults] setObject:mutDict forKey:@"downloaded_images"];
    
    UIImage *image = [UIImage imageWithData:self.imageData];
    [self.delegateDownload downloadedImage:image atIndexPath:self.indexPathOfRow];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Not loaded image!");
}




@end
