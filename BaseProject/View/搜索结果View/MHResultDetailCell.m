//
//  MHResultDetailCell.m
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHResultDetailCell.h"

@implementation MHResultDetailCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)ResutlDetailCell {

    return [[NSBundle mainBundle] loadNibNamed:@"MHResultDetailCell" owner:nil options:nil].firstObject;
}
@end
