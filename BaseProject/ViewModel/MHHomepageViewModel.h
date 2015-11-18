//
//  MHHomepageViewModel.h
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHHomepageNetManager.h"
@interface MHHomepageViewModel : BaseViewModel

@property(nonatomic,strong)NSMutableArray *dataArr;
/**
 *  中间滚动 以及最下面的中版推荐部分
 */
- (void)getDataCompleteHandle:(void(^)(NSError *error))complete;
@end
