//
//  MHDetailNetManager.m
//  MH漫画控
//
//  Created by mis on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetailNetManager.h"

@implementation MHDetailNetManager
+ (id)getDetaiData:(NSInteger)ID comletionHandle:(void(^)(NSMutableArray *models,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"https://pi.comikon.net/product/?format=json&content_type__model=bookres&meta_id=%ld",ID];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"results"];
        completionHandle([MHDetailModel objectArrayWithKeyValuesArray:arr],error);
    }];
    
}
+ (id)getListData:(NSString *)type withPage:(NSInteger)page comletionHandle:(void(^)(NSMutableArray *listModel,NSError *error))comletionHandle {
    NSString *path = [NSString stringWithFormat:@"https://pi.comikon.net/collection/%@/?page=%ld&page_size=20&format=json",type,page];
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        NSArray *arr = responseObj[@"results"];
        comletionHandle([MHDetailListModel objectArrayWithKeyValuesArray:arr],error);
    }];
}
+ (id)getShortDetaiData:(NSInteger)ID comletionHandle:(void(^)(MHDetailObjectModel *model,NSError *error))completionHandle {
    NSString *path = [NSString stringWithFormat:@"https://bone.comikon.net/v8.3/comics/%ld/resources/?format=json",ID];
    
    return [self GET:path parameters:nil completionHandler:^(id responseObj, NSError *error) {
        completionHandle([MHDetailObjectModel objectWithKeyValues:responseObj],error);
    }];
}
@end
