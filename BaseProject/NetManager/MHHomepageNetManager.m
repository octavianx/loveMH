//
//  MHHomepageNetManager.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHomepageNetManager.h"

@implementation MHHomepageNetManager
+ (id)gethomepage:(NSString *)type completionHandle:(void(^)(NSMutableArray *models,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"https://pi.comikon.net/store/%@/?format=json",type];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"results"];
        completionHandle([MHHomepageModel objectArrayWithKeyValuesArray:arr],error);
    }];
}
@end
