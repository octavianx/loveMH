//
//  MHDetailListModel.m
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetailListModel.h"

@implementation MHDetailListModel
+ (NSDictionary *)objectClassInArray {
    return @{@"objects":[MHDetailListObjectModel class]};
}

@end

@implementation MHDetailListObjectModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"desc":@"description"};
}
+ (NSDictionary *)objectClassInArray {
    return @{@"screenshot":[MHDetailListScreenshotModel class],@"resources":[MHDetailListreSourcesModel class]};
}

@end
@implementation MHDetailListScreenshotModel



@end

@implementation MHDetailListreSourcesModel



@end