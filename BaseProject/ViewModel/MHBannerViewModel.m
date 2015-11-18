//
//  MHBannerViewModel.m
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHBannerViewModel.h"
@interface MHBannerNetManager ()


@end

@implementation MHBannerViewModel
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
    
}
- (NSMutableArray *)imageModels {
    if (!_imageModels) {
        _imageModels = [NSMutableArray new];
    }
    return _imageModels;
}
- (NSMutableArray *)headImageURLs {
    if (!_headImageURLs) {
        _headImageURLs = [NSMutableArray new];
   
    }
    return _headImageURLs;
}
- (NSMutableArray *)namesImageURls {
    if (!_namesImageURls) {
        _namesImageURls = [NSMutableArray new];
        
    }
    return _namesImageURls;
}
- (void)getDataCompleteHandle:(void(^)(NSError *error))complete {
    
    [self.dataTask cancel];
    NSString *type = @"banner";
   self.dataTask = [MHBannerNetManager getBanner:type completionHandle:^(NSMutableArray *models, NSError *error) {
//        [self.dataArr removeAllObjects];
        self.dataArr = [models copy];
        for (MHBannerModel *model in _dataArr) {
            [MHBannerNetManager getBanerCover:model.image_set_id completionHandle:^(MHBannerCoverModel *coverModels, NSError *error) {
                [self.imageModels addObject:coverModels];
                [self.headImageURLs addObject:coverModels.image_url];
                [self.namesImageURls addObject:coverModels.title];
                complete(error);
            }];
            
        }
        complete(error);
    }];
    
}
- (NSString *)titleForPage:(NSInteger)page {
    if (self.namesImageURls.count == 0) {
        return nil;
    }
    NSString *name = [self.namesImageURls[page] componentsSeparatedByString:@"_"].lastObject;
    return name;
}
- (NSString *)descForPage:(NSInteger)page {
    if (self.imageModels.count == 0) {
        return nil;
    }
    MHBannerModel *model = [self getDescArray][page];
    return model.desc;
}
- (NSArray *)getDescArray {
    NSMutableArray *arr = [NSMutableArray new];
    for (MHBannerCoverModel *Covermodel in self.imageModels) {
        for (MHBannerModel *model in self.dataArr ) {
            if ([Covermodel.image_set isEqualToNumber:model.image_set_id]) {
                [arr addObject: model];
                break;
            }
        }
    }
    return [arr copy];
}
@end
