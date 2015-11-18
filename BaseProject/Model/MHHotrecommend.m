//
//  MHHotrecommend.m
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHotrecommend.h"

@implementation MHHotrecommendModel
+ (NSDictionary *)objectClassInArray {
    return @{@"objects":[MHHotrecommendObject class]};
}

@end

@implementation MHHotrecommendObject

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"desc":@"description"};
}
+ (NSDictionary *)objectClassInArray {
    return @{@"resources":[MHHotrecommendResources class],@"screenshot":[MHHotrecommendScreenshot class]};
}
@end

@implementation MHHotrecommendScreenshot

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end

@implementation MHHotrecommendResources

+ (NSDictionary *)objectClassInArray {
    return @{@"site":[MHHotrecommendSite class]};
}

@end

@implementation MHHotrecommendSite



@end






