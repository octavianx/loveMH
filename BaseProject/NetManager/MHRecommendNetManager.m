//
//  MHRecommendNetManager.m
//  MH漫画控
//
//  Created by mis on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHRecommendNetManager.h"

@implementation MHRecommendNetManager
+ (id)getRecommendDataWithID:(NSInteger)ID completionHandle:(void(^)(NSMutableArray *recommneds ,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"https://bone.comikon.net/v8.3/recommend/comic/%ld/?format=json",ID];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([MHRecommendModel objectArrayWithKeyValuesArray:responseObj],error);
    }];
}
@end
