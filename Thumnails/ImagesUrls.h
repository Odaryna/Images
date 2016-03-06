//
//  ImagesUrls.h
//  Thumnails
//
//  Created by Admin on 3/5/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImagesUrls : NSObject

+ (instancetype)sharedInstance;

- (void)createArrayWithNamesAndUrls;
- (NSString *)urlForImageByIndex:(NSUInteger)index;
- (NSString *)nameForImageByIndex:(NSUInteger)index;

@end
