//
//  MHDetailListViewModel.m
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetailListViewModel.h"

@implementation MHDetailListViewModel
- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray new];
        
    }
    
    return _dataArr;
}
- (NSInteger)rowNum {
    
    return self.dataArr.count/2.0;
    
}
- (void)getListdataWithSlug:(NSString *)slug withPage:(NSInteger)page Completion:(void(^)(NSError *error))complete {
    [MHDetailNetManager getListData:slug withPage:page comletionHandle:^(NSMutableArray *listModel, NSError *error) {
        for (MHDetailListModel *model in listModel) {
  
            [self.dataArr addObject:model.objects];
   
        }
          complete(error);
    }];
    
}
- (void)getMoreDataWithSlug:(NSString *)slug Completion:(void(^)(NSError *error))complete {
    self.page += 1;
    if (_page > 2) {
          NSError *err=[NSError errorWithDomain:@"" code:999 userInfo:@{NSLocalizedDescriptionKey:@"没有更多数据了"}];
        complete(err);
    }else {
        
        [self getListdataWithSlug:slug  withPage:self.page Completion:complete];
    }
    
    
}
- (void)getRefrshDataWithSlug:(NSString *)slug Completion:(void(^)(NSError *error))complete {
    self.page = 1;
    
    [self getListdataWithSlug:slug withPage:self.page Completion:complete];
}
- (MHDetailListObjectModel *)objectForRow:(NSInteger)row {
    MHDetailListObjectModel *object = self.dataArr[row];
    
    return object;
}

@end
