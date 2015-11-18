//
//  MHSearchResultViewModel.m
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHSearchResultViewModel.h"

@implementation MHSearchResultViewModel
- (NSInteger)rowNum {
    return self.searchsArr.count;
}
- (NSMutableArray *)searchsArr {
    if (!_searchsArr) {
        _searchsArr = [NSMutableArray new];
    }
    return _searchsArr;
}
- (void)getSearchResultData:(NSString *)SearchText completionHandle:(void(^)(NSError *error))complete {
    [MHSearchNetManager getSearchDataWithSearchText:SearchText completionHandle:^(NSMutableArray *searchs, NSError *error) {
        [self.searchsArr removeAllObjects];
        for (MHSearchBaseModel *search in searchs) {
            [self.searchsArr addObject:search];
        }
        complete(error);
    }];
}
- (MHSearchBaseModel *)searchModelForRow:(NSInteger)row {
    return self.searchsArr[row];
}
-(NSString *)titleForRow:(NSInteger)row {
    return [self searchModelForRow:row].comic_name;
}
@end
