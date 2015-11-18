//
//  MHSearchNetManager.m
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHSearchNetManager.h"

@implementation MHSearchNetManager
+ (id)getSearchDataWithSearchText:(NSString *)searchText completionHandle:(void(^)(NSMutableArray *searchs ,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"https://bone.comikon.net/v8.3/search/?format=json&keyphrase=%@&page_index=1&page_size=20",searchText];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"comics"];
       completionHandle([MHSearchBaseModel objectArrayWithKeyValuesArray:arr],error);
        
    }];
}
+ (id)getResultDetailWithName:(NSString *)name completionHandle:(void(^)(NSMutableArray *comics,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"https://bone.comikon.net/v8.3/search/?format=json&keyphrase=%@&page_index=1&page_size=20",name];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"comics"];
        completionHandle([MHResultDetailComicsModel objectArrayWithKeyValuesArray:arr],error);
    }];
}
@end
