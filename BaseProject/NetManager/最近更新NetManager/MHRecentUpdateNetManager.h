//
//  MHRecentUpdateNetManager.h
//  MHK
//
//  Created by mis on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MHRecentUpdateModel.h"
@interface MHRecentUpdateNetManager : BaseNetManager
+ (id)getRecentUpdataWith:(NSInteger) page withCompletionHandle:(void(^)(id model , NSError *error))completionHandle;
@end
