//
//  MHNewCollectionViewModel.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHNewCollectionViewModel.h"

@implementation MHNewCollectionViewModel
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)getDataCompleteHanle:(void(^)(NSError *error))complete {
    NSString *type = @"collection/new";
    [MHNewCollectionNetManager getNewCollection:type completionHandle:^(NSMutableArray *models, NSError *error) {
        [self.dataArr removeAllObjects];
        for (MHHotrecommendModel *model in models) {
            [self.dataArr addObject:model.objects];
        }
        complete(error);
    }];
}
@end
