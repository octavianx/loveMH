//
//  MHContentModel.m
//  MH漫画控
//
//  Created by mis on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHContentModel.h"

@implementation MHContentModel

@end
@implementation MHComtentResult

+ (NSDictionary *)objectClassInArray{
    return @{@"chapterList" : [MHChapterlistModel class]};
}

@end


@implementation MHChapterlistModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end


