//
//  MHSearchResultViewModel.h
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHSearchNetManager.h"
@interface MHSearchResultViewModel : BaseViewModel

@property(nonatomic,strong)NSMutableArray *searchsArr;

@property(nonatomic)NSInteger rowNum;
- (void)getSearchResultData:(NSString *)SearchText completionHandle:(void(^)(NSError *error))complete;

-(NSString *)titleForRow:(NSInteger)row;

@end
