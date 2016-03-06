//
//  ImagesTableVC.m
//  Thumnails
//
//  Created by Admin on 3/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ImagesTableVC.h"
#import "ImagesCellVC.h"
#import "ImagesUrls.h"
#import "ImageViewController.h"

@interface ImagesTableVC () <DownloadedImages, UISplitViewControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary *images;
@property (strong, nonatomic) NSMutableDictionary *oldImages;
@property (strong, nonatomic) UIImage *selectedImage;

@property (assign, nonatomic) BOOL shouldCollapseDetailViewController;

@end

@implementation ImagesTableVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shouldCollapseDetailViewController = true;
    self.splitViewController.delegate = self;
    
    self.images = [NSMutableDictionary new];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"downloaded_images"];
    if (dict)
    {
        NSArray *keys = [dict allKeys];
        NSArray *values = [dict allValues];
        self.oldImages = [NSMutableDictionary new];
       
        for(int index = 0; index < [keys count]; index++)
        {
            [self.oldImages setObject:[UIImage imageWithData:[values objectAtIndex:index]] forKey:[keys objectAtIndex:index]];
        }
    }

    ImagesUrls *imgUrls = [ImagesUrls sharedInstance];
    [imgUrls createArrayWithNamesAndUrls];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImagesCellVC *cell = (ImagesCellVC *)[tableView dequeueReusableCellWithIdentifier:@"ImagesCell" forIndexPath:indexPath];
    
    if ([self.oldImages count])
    {
        NSArray *keys = [self.oldImages allKeys];
        for (NSString *key in keys)
        {
            if ([[NSString stringWithFormat:@"%lu",indexPath.row] isEqualToString:key])
            {
                cell.imageIsDownloaded = YES;
                [self.images setObject:[self.oldImages objectForKey:key] forKey:key];
                [self.oldImages removeObjectForKey:key];
                break;
            }
        }
    }
    
    cell.imageName.text = [[ImagesUrls sharedInstance] nameForImageByIndex:indexPath.row];
    cell.image.image = [UIImage imageNamed:[[ImagesUrls sharedInstance] nameForImageByIndex:indexPath.row]];
    cell.indexOfRow = indexPath.row;
    cell.delegateDownload = self;
    
    if (!cell.imageIsDownloading)
    {
        [cell.downloadButton setImage:[UIImage imageNamed:@"windows_7_download_library_ico_by_sdbinwiiexe-d3c9fb7.png"] forState:UIControlStateNormal];
        cell.progressView.hidden = YES;
    }
    else
    {
        cell.progressView.hidden = NO;
        [cell.downloadButton setImage:nil forState:UIControlStateNormal];
        [cell.downloadButton setTitle:@"⬛️" forState: UIControlStateNormal];
    }
    
    if (cell.imageIsDownloaded)
    {
        cell.downloadButton.hidden = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.shouldCollapseDetailViewController = false;
    
    NSString* key = [NSString stringWithFormat:@"%lu", indexPath.row];
    NSArray *allKeys = [self.images allKeys];
    
    for (NSString *str in allKeys) {
        if ([str isEqualToString:key])
        {
            self.selectedImage = (UIImage *)[self.images objectForKey:key];
            [self performSegueWithIdentifier:@"showImage" sender:self];
            break;
        }
    }

}

-(void)downloadedImage:(UIImage *)image forKey:(NSUInteger)index
{
    [self.images setObject:image forKey:[NSString stringWithFormat:@"%lu", index]];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showImage"])
    {
        ImageViewController* ivc = (ImageViewController *)segue.destinationViewController;
        ivc.fullImage = self.selectedImage;
    }
}

#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return self.shouldCollapseDetailViewController;
}


@end
