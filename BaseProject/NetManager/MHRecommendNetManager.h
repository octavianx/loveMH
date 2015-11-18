//
//  MHRecommendNetManager.h
//  MH漫画控
//
//  Created by mis on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MHRecommendModel.h"
@interface MHRecommendNetManager : BaseNetManager
+ (id)getRecommendDataWithID:(NSInteger)ID completionHandle:(void(^)(NSMutableArray *recommneds ,NSError *error))completionHandle;
@end
