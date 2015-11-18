//
//  MHContentViewModel.m
//  MH漫画控
//
//  Created by mis on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHContentViewModel.h"
#import "MHContentModel.h"
@implementation MHContentViewModel
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray new];
    }
    return _dataArr;
}
- (NSInteger)rowNum {
    return self.dataArr.count;
}
- (void)getContentdataWithName:(NSString *)name completionHandle:(void(^)(NSError *error))complete {
    
    [MHContentNetManager getContentWithName:name completionHandle:^(MHContentModel *model, NSError *error) {
        NSMutableArray  *arr = [NSMutableArray new];
        MHComtentResult *result = model.result;
        self.name = result.comicName;
        for (MHChapterlistModel *listModel  in model.result.chapterList) {
            [arr addObject:listModel];
        }
        
        self.dataArr = [arr copy];
        complete(error);
    }];
}
- (MHChapterlistModel *)modelForRow:(NSInteger)row {
    return self.dataArr[row];
}
- (NSString *)titleForRow:(NSInteger)row {
    return [self modelForRow:row].name;
}
- (NSInteger )idForRow:(NSInteger)row {
    return [self modelForRow:row].ID;
}
- (NSString *)nameForRow:(NSInteger)row {
    
    return self.name;
}
@end
