//
//  MHBannerNetManager.m
//  MHK漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHBannerNetManager.h"

@implementation MHBannerNetManager

+ (id)getBanner:(NSString *)tpye completionHandle:(void(^)(NSMutableArray *models,NSError *error))completionjHandle {
    NSString *path = [NSString stringWithFormat:@"https://pi.comikon.net/%@/?format=json&platform=ios",tpye];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr  = responseObj[@"results"];
        completionjHandle([MHBannerModel mj_objectArrayWithKeyValuesArray:arr],error);
    }];
}
+ (id)getBanerCover:(NSNumber *)imageSet completionHandle:(void(^)(MHBannerCoverModel *coverModels,NSError *error))completionHandle {
    NSString *path =[NSString stringWithFormat:@"https://pi.comikon.net/imagegroup/%@/autopick/?format=json&height=440&match=both&width=640",imageSet];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([MHBannerCoverModel mj_objectWithKeyValues:responseObj],error);
    }];
}
@end
