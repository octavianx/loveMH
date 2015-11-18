//
//  MHHomeCover.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHomeCover.h"

@implementation MHHomeCover

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)item {
    return [[NSBundle mainBundle] loadNibNamed:@"MHHomeCover" owner:nil options:nil].firstObject;
}

@end
