//
//  MHHomeHeaderView.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHomeHeaderView.h"

@implementation MHHomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"MHHomeHeaderView" owner:nil options:nil].firstObject;
}

@end
