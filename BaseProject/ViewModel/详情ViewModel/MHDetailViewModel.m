//
//  MHDetailViewModel.m
//  MH漫画控
//
//  Created by mis on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetailViewModel.h"

@implementation MHDetailViewModel
- (NSArray *)screenhot {
    if (!_screenhot) {
        _screenhot = [NSArray new];
    }
    return _screenhot;
}
- (NSArray *)marks {
    if (!_marks) {
        _marks = [NSArray new];
    }
    return _marks;
}
-(void)getdataWith:(NSInteger)ID CompeltionHandel:(void(^)(NSError *error))complete {
    [self.dataTask cancel];
    self.dataTask =   [MHDetailNetManager getDetaiData:ID comletionHandle:^(NSMutableArray *models, NSError *error) {
        MHDetailModel *detailModel = models.firstObject;
        self.object = detailModel.objects;
        self.screenhot = detailModel.objects.screenshot;
        self.marks = detailModel.marks;
        complete(error);
    }];
    
}
-(void)getOtherObjectWith:(NSInteger)ID CompeltionHandel:(void(^)(NSError *error))complete {
    [MHDetailNetManager getShortDetaiData:ID comletionHandle:^(MHDetailObjectModel *model, NSError *error) {
        self.screenhot = model.screenshot;
        /**
         *  防止服务器传回的object为NIl;
         */
        self.object = model;
        complete(error);
    }];
}
@end
