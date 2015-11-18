//
//  MHContentNetManager.m
//  MH漫画控
//
//  Created by mis on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHContentNetManager.h"
#import "MHContentModel.h"
@implementation MHContentNetManager
+ (id)getContentWithName:(NSString *)title completionHandle:(void(^)(id model,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"http://japi.juhe.cn/comic/chapter?comicName=%@&key=3e20122f5788ea8fc99ef25f3bc90cd0",title];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([MHContentModel objectWithKeyValues:responseObj],error);
    }];
}+ (id)getDetailImagesWithName:(NSString *)name chpate_id:(NSInteger )ID completionHandle:(void(^)(id model,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"http://japi.juhe.cn/comic/chapterContent?comicName=%@&id=%ld&key=3e20122f5788ea8fc99ef25f3bc90cd0",name,ID];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"result"][@"imageList"];
        completionHandle([MHContentImage objectArrayWithKeyValuesArray:arr],error);
    }];
}
@end
