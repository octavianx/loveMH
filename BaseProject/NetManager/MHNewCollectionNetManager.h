//
//  MHNewCollectionNetManager.h
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "MHNewCollectionModel.h"
@interface MHNewCollectionNetManager : BaseNetManager
+ (id)getNewCollection:(NSString *)type completionHandle:(void(^)(NSMutableArray *models ,NSError *error))completionHandle;
@end
