//
//  MHResultDetailViewModel.h
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHSearchNetManager.h"
@interface MHResultDetailViewModel : BaseViewModel

/**
 *  所有结果数组
 */
@property(nonatomic,strong)NSMutableArray *results;

@property(nonatomic)NSInteger rowNum;

- (NSURL *)coverIconForRow:(NSInteger)row;

- (NSString *)authorForRow:(NSInteger)row;

- (NSString *)nameForRow:(NSInteger)row;

- (NSString *)buttonTitleForRow:(NSInteger)row;

- (NSInteger )comicIDForRow:(NSInteger)row;

- (void)getResultsDataWithName:(NSString *)name completionHandle:(void(^)(NSError *error))complete;

@end
