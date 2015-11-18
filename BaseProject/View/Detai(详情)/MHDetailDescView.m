//
//  MHDetailDescView.m
//  MH漫画控
//
//  Created by mis on 15/10/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetailDescView.h"

@implementation MHDetailDescView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)DetailDesc {
    return [[NSBundle mainBundle] loadNibNamed:@"MHDetailDescView" owner:nil options:nil].firstObject;
}

@end
