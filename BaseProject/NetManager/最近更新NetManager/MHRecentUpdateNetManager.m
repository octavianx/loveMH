//
//  MHRecentUpdateNetManager.m
//  MHK
//
//  Created by mis on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHRecentUpdateNetManager.h"

@implementation MHRecentUpdateNetManager
+ (id)getRecentUpdataWith:(NSInteger) page withCompletionHandle:(void(^)(id model , NSError *error))completionHandl {
    NSString *path = [NSString stringWithFormat:@"https://bone.comikon.net/v8.3/index/cat/最近更新/page/%ld/?format=json",page];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"index"][@"books"][0][@"最近更新"];
        completionHandl([MHRecentUpdateModel mj_objectArrayWithKeyValuesArray:arr],error);
        
    }];
    
}
@end
