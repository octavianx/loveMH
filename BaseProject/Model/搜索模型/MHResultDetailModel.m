//
//  MHResultDetailModel.m
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHResultDetailModel.h"

@implementation MHResultDetailModel
+(NSDictionary *)objectClassInArray {
    
    return @{@"comics":[MHResultDetailComicsModel class]};
}

@end


@implementation MHResultDetailComicsModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"desc":@"description"};
}

@end