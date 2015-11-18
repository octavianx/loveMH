//
//  MHBannerModel.m
//  MHK漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHBannerModel.h"

@implementation MHBannerModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id" };
}
+ (NSDictionary *) objectClassInArray {
    return @{@"objects":[MHBannerObjectModel class]};
}
@end

@implementation MHBannerObjectModel



@end