//
//  MHRecommendViewModel.m
//  MH漫画控
//
//  Created by mis on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHRecommendViewModel.h"

@implementation MHRecommendViewModel

- (NSInteger)count {
    return self.dataArr.count;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (void)getRecommendWithID:(NSInteger)ID CompletionHandle:(void(^)(NSError *error))complete {
    [self.dataTask cancel];
    self.dataTask = [MHRecommendNetManager getRecommendDataWithID:ID completionHandle:^(NSMutableArray *recommneds, NSError *error) {
        self.dataArr = recommneds;
        complete(error);
    }];
}
@end
