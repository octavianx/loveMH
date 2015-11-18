//
//  MHRecommendViewModel.h
//  MH漫画控
//
//  Created by mis on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHRecommendNetManager.h"
@interface MHRecommendViewModel : BaseViewModel


@property(nonatomic)NSInteger count;
/**
 *  存放的为recomend模型
 */
@property(nonatomic,strong)NSMutableArray *dataArr;

- (void)getRecommendWithID:(NSInteger)ID CompletionHandle:(void(^)(NSError *error))complete;

@end
