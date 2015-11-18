//
//  MHContentViewModel.m
//  MHK
//
//  Created by mis on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHContentImgaeViewModel.h"

@implementation MHContentImgaeViewModel
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}
- (NSInteger)rowNum {
    return self.dataArr.count;
}
- (void)getDataWith:(NSString *)name chpate_id:(NSInteger)ID completionHandle:(void(^)(NSError *error))comlepte {
    [MHContentNetManager getDetailImagesWithName:name chpate_id:ID completionHandle:^(NSMutableArray *model, NSError *error) {
        NSMutableArray *arr = [NSMutableArray new];
        for (MHContentImage *imageModel in model) {
            NSURL *url = [NSURL URLWithString:imageModel.imageUrl];
            [arr addObject:url];
        }
        self.dataArr = arr;
        comlepte(error);

    }];
}
- (NSURL *)urlForRow:(NSInteger)row {
    return self.dataArr[row];
}
@end
