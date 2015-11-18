//
//  MHRecentUpdateViewModel.h
//  MHK
//
//  Created by mis on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHRecentUpdateNetManager.h"
@interface MHRecentUpdateViewModel : BaseViewModel

/**
 *  储存的MHRecentUpdateModel的数组
 */
@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic)NSInteger rowNum;

@property(nonatomic)NSInteger page;

- (void)getRecentDataWith:(NSInteger)page completionHandle:(void(^)(NSError *error))complete;

- (void)refreschDataWithCompletionHandle:(void(^)(NSError *error))complete;

- (void)getMoreDateWithCompletionHandle:(void(^)(NSError *error))complete;

- (NSString *)titleForRow:(NSInteger)row;

- (NSURL *)iconViewForRow:(NSInteger)row;
- (NSInteger)IdForRow:(NSInteger)row;

@end
