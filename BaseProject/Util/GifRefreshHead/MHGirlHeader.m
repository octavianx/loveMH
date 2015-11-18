//
//  MHGirlHeader.m
//  MH漫画
//
//  Created by mis on 15/10/22.
//  Copyright © 2015年 mis. All rights reserved.
//

#import "MHGirlHeader.h"

@implementation MHGirlHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"filtercolor_style%ld", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
