//
//  MHHotrecommandViewModel.h
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHHotrecommendNetManager.h"
@interface MHHotrecommandViewModel : BaseViewModel
/**
 *  根据序号返回对应的封面
 */
- (NSURL *)coverIconForNum:(NSInteger)Num;
/**
 *  根据序号返回对应的标题
 */
- (NSString *)titleForNum:(NSInteger)Num;
/**
 *  根据序号返回对应的作者
 */
- (NSString *)authorForNum:(NSInteger)Num;
/**
 *  获取最热门推荐数据
 */
- (void)getDataCompleteHandle:(void(^)(NSError *error))complete;
/**
 *  objects 数组
 */
@property (nonatomic,strong)NSMutableArray *objects;

@end
