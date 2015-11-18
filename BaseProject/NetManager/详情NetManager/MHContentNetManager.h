//
//  MHContentNetManager.h
//  MH漫画控
//
//  Created by mis on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MHContentImage.h"
@interface MHContentNetManager : BaseNetManager
+ (id)getContentWithName:(NSString *)title completionHandle:(void(^)(id model,NSError *error))completionHandle;
+ (id)getDetailImagesWithName:(NSString *)name chpate_id:(NSInteger )ID completionHandle:(void(^)(id model,NSError *error))completionHandle;
@end
