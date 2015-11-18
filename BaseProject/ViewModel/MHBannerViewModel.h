//
//  MHBannerViewModel.h
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHBannerNetManager.h"
@interface MHBannerViewModel : BaseViewModel
/**
 *  返回所有的banner模型
 */
@property(nonatomic,strong) NSMutableArray *dataArr;
//头部滚动栏，图片数组
/**
 *  返回所有的图片
 */
@property(nonatomic,strong) NSMutableArray *headImageURLs;

@property(nonatomic,strong) NSMutableArray *namesImageURls;

@property(nonatomic,strong)NSMutableArray *imageModels;

//获得数据
- (void)getDataCompleteHandle:(void(^)(NSError *error))complete;
/**
 *  动漫的名称标签
 */
- (NSString *)titleForPage:(NSInteger)page;
/**
 *  动漫的简单描述标签
 */
- (NSString *)descForPage:(NSInteger)page;
@end
