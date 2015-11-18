//
//  MHHomepageModel.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHomepageModel.h"

@implementation MHHomepageModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return  @{@"ID":@"id"};
}

+ (NSDictionary *)objectClassInArray {
    return @{@"objects":[MHHomepageObjectModel class]};
}

@end

@implementation MHHomepageObjectModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return  @{@"ID":@"id"};
}

@end