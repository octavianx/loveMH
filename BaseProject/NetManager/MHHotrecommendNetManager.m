//
//  MHHotrecommendNetManager.m
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHotrecommendNetManager.h"

@implementation MHHotrecommendNetManager
+ (id)getHotrecommend:(NSString *)tpye completionHandle:(void(^)(NSMutableArray *models,NSError *error))completionjHandle {
    NSString *path = [NSString stringWithFormat:@"https://pi.comikon.net/collection/%@/gallery/?format=json",tpye];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"results"];
        completionjHandle([MHHotrecommendModel objectArrayWithKeyValuesArray:arr],error);
    }];
}
@end
