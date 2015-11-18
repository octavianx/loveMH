//
//  MHRecentUpdateViewModel.m
//  MHK
//
//  Created by mis on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHRecentUpdateViewModel.h"

@implementation MHRecentUpdateViewModel
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (NSInteger)rowNum {
    return self.dataArr.count;
}
- (void)getRecentDataWith:(NSInteger)page completionHandle:(void(^)(NSError *error))complete {
    [MHRecentUpdateNetManager getRecentUpdataWith:page withCompletionHandle:^(NSMutableArray *model, NSError *error) {
        if (_page == 1) {
            [self.dataArr removeAllObjects];
        }
        [self.dataArr addObjectsFromArray:model];
        complete(error);
    }];
    
}
- (void)refreschDataWithCompletionHandle:(void(^)(NSError *error))complete {
    _page = 1;
    [self getRecentDataWith:_page completionHandle:complete];
}

- (void)getMoreDateWithCompletionHandle:(void(^)(NSError *error))complete {
    _page += 1;
    if (_page >= 60) {
        NSError *err = [NSError errorWithDomain:@"" code:999 userInfo:@{NSLocalizedDescriptionKey:@"没有更多数据了"}];
        complete(err);
    }else {
        [self getRecentDataWith:_page completionHandle:complete];
    }
    
}
- (MHRecentUpdateModel *)modelForRow:(NSInteger)row {
    return self.dataArr[row];
}
- (NSString *)titleForRow:(NSInteger)row {
    return [self modelForRow:row].comic_name;
}

- (NSURL *)iconViewForRow:(NSInteger)row {
    return [NSURL URLWithString:[self modelForRow:row].comic_cover];
}
- (NSInteger)IdForRow:(NSInteger)row {
    return [self modelForRow:row].comic_id.integerValue;
}

@end
