//
//  MHHotrecommendNetManager.h
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MHHotrecommend.h"
@interface MHHotrecommendNetManager : BaseNetManager
+ (id)getHotrecommend:(NSString *)tpye completionHandle:(void(^)(NSMutableArray *models,NSError *error))completionjHandle;
@end
