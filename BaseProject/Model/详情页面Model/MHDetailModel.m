//
//  MHDetailModel.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetailModel.h"

@implementation MHDetailModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
+ (NSDictionary *)objectClassInArray {
    return @{@"objects":[MHDetailObjectModel class],@"tags":[MHDetailTagsModel class],@"marks":[MHDetailMarksModel class]};
}
@end

@implementation MHDetailObjectModel

+ (NSDictionary *)replacedKeyFromPropertyName {
   return  @{@"desc":@"description"};
}

+ (NSDictionary *)objectClassInArray {
    return  @{@"screenshot": [MHDetailScreenshotModel class],@"resources":[MHDetailResourcesModel class]};
}
@end

@implementation MHDetailScreenshotModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}


@end

@implementation MHDetailResourcesModel



@end

@implementation MHDetailTagsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end

@implementation MHDetailMarksModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end