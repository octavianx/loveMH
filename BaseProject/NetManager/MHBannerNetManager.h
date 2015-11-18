//
//  MHBannerNetManager.h
//  MHK漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MHBannerModel.h"
#import "MHBannerCoverModel.h"
@interface MHBannerNetManager : BaseNetManager
/**
 *返回一个banner的数组，里面都是MHbannerModel类型的对象
 */
+ (id)getBanner:(NSString *)tpye completionHandle:(void(^)(NSMutableArray *models,NSError *error))completionjHandle;
+ (id)getBanerCover:(NSNumber *)imageSet completionHandle:(void(^)(MHBannerCoverModel *coverModels,NSError *error))completionHandle;
@end
