//
//  MHDetailListViewModel.h
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHDetailNetManager.h"

@interface MHDetailListViewModel : BaseViewModel

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic)NSInteger rowNum;

@property(nonatomic)NSInteger page;

//- (void)getListdataWithSlug:(NSString *)slug Completion:(void(^)(NSError *error))complete;
- (void)getRefrshDataWithSlug:(NSString *)slug Completion:(void(^)(NSError *error))complete;
- (void)getMoreDataWithSlug:(NSString *)slug Completion:(void(^)(NSError *error))complete;
- (MHDetailListObjectModel *)objectForRow:(NSInteger)row ;
@end
