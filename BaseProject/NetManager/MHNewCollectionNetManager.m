//
//  MHNewCollectionNetManager.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHNewCollectionNetManager.h"

@implementation MHNewCollectionNetManager
+ (id)getNewCollection:(NSString *)type completionHandle:(void(^)(NSMutableArray *models ,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"https://pi.comikon.net/%@/gallery/?format=json",type];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"results"];
        completionHandle([MHNewCollectionModel  objectArrayWithKeyValuesArray:arr],error);
    }];
}
@end
