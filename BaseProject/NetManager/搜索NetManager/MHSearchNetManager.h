//
//  MHSearchNetManager.h
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MHSearchBaseModel.h"
#import "MHResultDetailModel.h"
@interface MHSearchNetManager : BaseNetManager
+ (id)getSearchDataWithSearchText:(NSString *)searchText completionHandle:(void(^)(NSMutableArray *searchs ,NSError *error))completionHandle;

+ (id)getResultDetailWithName:(NSString *)name completionHandle:(void(^)(NSMutableArray *comics,NSError *error))completionHandle;
@end
