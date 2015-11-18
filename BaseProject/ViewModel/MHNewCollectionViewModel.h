//
//  MHNewCollectionViewModel.h
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHNewCollectionNetManager.h"
@interface MHNewCollectionViewModel : BaseViewModel
/**
 *  objects 数组
 */
@property(nonatomic,strong)NSMutableArray *dataArr;

- (void)getDataCompleteHanle:(void(^)(NSError *error))complete;

@end
