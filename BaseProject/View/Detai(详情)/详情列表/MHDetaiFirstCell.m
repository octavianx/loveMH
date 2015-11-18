//
//  MHDetaiFirstCell.m
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetaiFirstCell.h"

@implementation MHDetaiFirstCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)DetailFirsCell {
    return [[NSBundle mainBundle] loadNibNamed:@"MHDetaiFirstCell" owner:nil options:nil ].firstObject;
}
@end
