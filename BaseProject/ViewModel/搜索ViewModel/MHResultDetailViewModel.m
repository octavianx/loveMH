//
//  MHResultDetailViewModel.m
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHResultDetailViewModel.h"

@implementation MHResultDetailViewModel
- (NSMutableArray *)results {
    if (!_results) {
        _results = [NSMutableArray new];
    }
    return _results;
}
- (NSInteger)rowNum {
    return self.results.count;
}
- (void)getResultsDataWithName:(NSString *)name completionHandle:(void(^)(NSError *error))complete {
    [MHSearchNetManager getResultDetailWithName:name completionHandle:^(NSMutableArray *comics, NSError *error) {
        self.results = comics;
        complete(error);
    }];
}
- (MHResultDetailComicsModel *)resultDetailModelForRow:(NSInteger)row {
    MHResultDetailComicsModel *resultModel = self.results[row];
    return resultModel;
}
- (NSURL *)coverIconForRow:(NSInteger)row {
    NSURL *coverURL = [NSURL URLWithString:[self resultDetailModelForRow:row].comic_cover];
    return coverURL;
}

- (NSString *)authorForRow:(NSInteger)row {
    return [self resultDetailModelForRow:row].comic_author;
}

- (NSString *)nameForRow:(NSInteger)row {
    return [self resultDetailModelForRow:row].comic_name;
}
- (NSString *)buttonTitleForRow:(NSInteger)row {
    return [self resultDetailModelForRow:row].unauthorized_resource_count.stringValue;
}
- (NSInteger )comicIDForRow:(NSInteger)row {
    return [self resultDetailModelForRow:row].comic_id.integerValue;
}
@end
