//
//  MHContentViewModel.h
//  MH漫画控
//
//  Created by mis on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHContentNetManager.h"
@interface MHContentViewModel : BaseViewModel

@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)NSString *name;
@property(nonatomic)NSInteger rowNum;

- (NSInteger )idForRow:(NSInteger)row;
- (NSString *)titleForRow:(NSInteger)row;
- (NSString *)nameForRow:(NSInteger)row;
- (void)getContentdataWithName:(NSString *)name completionHandle:(void(^)(NSError *error))complete;

@end
