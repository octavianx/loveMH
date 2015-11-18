//
//  MHHomepageViewModel.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHomepageViewModel.h"

@implementation MHHomepageViewModel
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        
    }
    return _dataArr;
}
- (void)getDataCompleteHandle:(void(^)(NSError *error))complete {
    NSString *type = @"homepage";
    [MHHomepageNetManager gethomepage:type completionHandle:^(NSMutableArray *models, NSError *error) {
        [self.dataArr removeAllObjects];
        for (MHHomepageModel *model in models) {
            [self.dataArr addObject:model.objects];
        }
        complete(error);
    }];
 
}
@end
