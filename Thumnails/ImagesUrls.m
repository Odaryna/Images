//
//  ImagesUrls.m
//  Thumnails
//
//  Created by Admin on 3/5/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ImagesUrls.h"

@interface ImagesUrls ()

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *urls;

@end

@implementation ImagesUrls

+ (instancetype)sharedInstance
{
    static ImagesUrls *ob;
    static dispatch_once_t predicat;
    
    dispatch_once(&predicat, ^{
        ob = [[ImagesUrls alloc]init];
    });
    
    return ob;
}


- (void)createArrayWithNamesAndUrls
{
    self.names = [[NSArray alloc] initWithObjects:@"bcf39e88-5731-43bb-9d4b-e5b3b2b1fdf2.jpg", @"ca1b8c69-9ba4-4586-a6b7-fe3e6e2112de.jpg", @"green_mountain_nature_wallpaper_hd.jpg", @"meadow_nature_summer_grass_sky_301_2560x1440.jpg", @"mountains_nature_sky_river_beautiful_scenery_93460_2560x1440.jpg", @"Parc-nature_de_la_Pointe-aux-Prairies_07.jpg", @"puppy_couple_sunset_nature_play_kids_1194_2560x1440.jpg", @"summer_mountains_nature_lake_river_grass_93164_2560x1440.jpg", @"summer_nature_grass_beautiful_light_84335_3840x2160.jpg", @"4239015-images-of-nature.jpg", @"City Wallpaper 14.jpg", @"new-york-city-hd.jpg", @"Skyline_oklahoma_city.JPG", @"4187330-pure-nature-hd.jpg", @"Nature-Spring-027.jpg", @"salton-sea-sra-c2a9greg-lucker.jpg", @"Iceberg,_Greenland_Sea_(js)1.jpg", @"Labrador-sea-paamiut.jpg", @"purple-flowers-butterflies-wide.jpg", @"23-Flowers-with-Butterfly-_10150291.jpg", nil];
    
    self.urls = [[NSArray alloc] initWithObjects: @"http://cdn.playbuzz.com/cdn/925704be-9b8e-4dfc-852e-f24d720cb9c5/bcf39e88-5731-43bb-9d4b-e5b3b2b1fdf2.jpg", @"http://cdn.playbuzz.com/cdn/51dfd8ac-08c7-4f98-8958-02bdba5468d2/ca1b8c69-9ba4-4586-a6b7-fe3e6e2112de.jpg", @"http://www.thedailyindia.in/wp-content/uploads/2015/10/green_mountain_nature_wallpaper_hd.jpg", @"https://wallpaperscraft.com/image/meadow_nature_summer_grass_sky_301_2560x1440.jpg", @"https://wallpaperscraft.com/image/mountains_nature_sky_river_beautiful_scenery_93460_2560x1440.jpg", @"https://upload.wikimedia.org/wikipedia/commons/5/59/Parc-nature_de_la_Pointe-aux-Prairies_07.jpg", @"https://wallpaperscraft.com/image/puppy_couple_sunset_nature_play_kids_1194_2560x1440.jpg", @"https://wallpaperscraft.com/image/summer_mountains_nature_lake_river_grass_93164_2560x1440.jpg", @"https://wallpaperscraft.com/image/summer_nature_grass_beautiful_light_84335_3840x2160.jpg", @"http://all4desktop.com/data_images/original/4239015-images-of-nature.jpg",@"http://server1.decornorth.com/images/www.hdwallpapersdesktop.com/Architecture/City/images/City%20Wallpaper%2014.jpg", @"http://server1.decornorth.com/images/www.mrwallpaper.com/wallpapers/new-york-city-hd.jpg", @"https://upload.wikimedia.org/wikipedia/commons/d/d8/Skyline_oklahoma_city.JPG", @"http://all4desktop.com/data_images/original/4187330-pure-nature-hd.jpg", @"http://www.thewallpapers.org/photo/76760/Nature-Spring-027.jpg", @"https://calparks.files.wordpress.com/2012/05/salton-sea-sra-c2a9greg-lucker.jpg", @"https://upload.wikimedia.org/wikipedia/commons/1/1f/Iceberg,_Greenland_Sea_(js)1.jpg", @"https://upload.wikimedia.org/wikipedia/commons/7/70/Labrador-sea-paamiut.jpg", @"http://www.hdwallpapers.org/walls/purple-flowers-butterflies-wide.jpg",        @"http://www.free-meditation.ca/wp-content/uploads/2010/05/23-Flowers-with-Butterfly-_10150291.jpg", nil];

}

-(NSString *)urlForImageByIndex:(NSUInteger)index
{
    if (index > 19)
    {
       return nil;
    }
    return [self.urls objectAtIndex:index];
}


-(NSString *)nameForImageByIndex:(NSUInteger)index
{
    if (index > 19)
    {
        return nil;
    }
    return [self.names objectAtIndex:index];
}

@end
