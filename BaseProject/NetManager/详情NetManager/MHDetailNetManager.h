//
//  MHDetailNetManager.h
//  MH漫画控
//
//  Created by mis on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MHDetailModel.h"
#import "MHDetailListModel.h"
@interface MHDetailNetManager : BaseNetManager

+ (id)getDetaiData:(NSInteger)ID comletionHandle:(void(^)(NSMutableArray *models,NSError *error))completionHandle;
+ (id)getListData:(NSString *)type withPage:(NSInteger)page comletionHandle:(void(^)(NSMutableArray *listModel,NSError *error))comletionHandle;
+ (id)getShortDetaiData:(NSInteger)ID comletionHandle:(void(^)(MHDetailObjectModel *model,NSError *error))completionHandle;

@end
