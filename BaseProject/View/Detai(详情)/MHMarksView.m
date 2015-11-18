//
//  MHMarksView.m
//  MH漫画控
//
//  Created by mis on 15/10/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHMarksView.h"
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
static CGFloat buttonH = 20;
static CGFloat buttonW = 40;
static CGFloat buttonM = 10;
@implementation MHMarksView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)setMarks:(NSArray *)marks {
    _marks = marks;
    UIButton *lastBtn = nil;
    for (int i = 0; i < marks.count; i ++) {
        UIButton *button  = [[UIButton alloc]init];
        
        button.layer.cornerRadius = 5;
        MHDetailMarksModel *model = marks[i];
        NSString *color = [model.color componentsSeparatedByString:@"#"].lastObject;
       
        NSInteger col = [self hexStringFromString:color];
        button.backgroundColor = HexRGB(col);
        [button setTitle:model.name forState:UIControlStateNormal];
       // button.backgroundColor = [UIColor lightGrayColor];
      // button.backgroundColor = HexRGB();
        
        [self addSubview:button];
        
        if (lastBtn == nil) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).mas_equalTo(buttonM);
                make.top.mas_equalTo(buttonM);
                make.width.mas_equalTo(buttonW);
                make.height.mas_equalTo(buttonH);
            }];
            
        }else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastBtn.mas_right).mas_equalTo(buttonM);
                make.top.mas_equalTo(buttonM);
                make.width.mas_equalTo(buttonW);
                make.height.mas_equalTo(buttonH);
            }];
        }
        lastBtn = button;
    }
    
}
- (NSInteger)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr.integerValue;
}

@end
