//
//  MHDetaiListCell.m
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetaiListCell.h"
@interface MHDetaiListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftCover;
@property (weak, nonatomic) IBOutlet UILabel *leftName;
@property (weak, nonatomic) IBOutlet UILabel *leftAuthor;
@property (weak, nonatomic) IBOutlet UILabel *leftStar;

@property (weak, nonatomic) IBOutlet UIImageView *rigthCover;
@property (weak, nonatomic) IBOutlet UILabel *rightName;
@property (weak, nonatomic) IBOutlet UILabel *rightAuthor;
@property (weak, nonatomic) IBOutlet UILabel *rightStart;

@property (weak, nonatomic) IBOutlet UIButton *leftbtn;

@property (weak, nonatomic) IBOutlet UIButton *rightbtn;

@end

@implementation MHDetaiListCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setLeftModel:(MHDetailListObjectModel *)leftModel {
    _leftModel = leftModel;
    self.leftName.text = leftModel.comic_name;
    [self.leftCover setImageWithURL:[NSURL URLWithString:leftModel.comic_cover]];
    self.leftAuthor.text = leftModel.comic_author;
    self.leftStar.text =[NSString stringWithFormat:@"%0.1f",leftModel.comic_score.floatValue];
    //设置button的ID为comic_id
    self.leftbtn.tag = leftModel.comic_id.integerValue;
    [self.leftbtn addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setRightModel:(MHDetailListObjectModel *)rightModel {
    _rightModel = rightModel ;
    self.rightName.text = rightModel.comic_name;
    [self.rigthCover setImageWithURL:[NSURL URLWithString:rightModel.comic_cover]];
    self.rightAuthor.text = rightModel.comic_author;
    if (_leftModel.comic_score.intValue == 0) {
        self.rightStart.text = @"暂无";
    }else {
        self.rightStart.text =[NSString stringWithFormat:@"%0.1f",rightModel.comic_score.floatValue];
    }
    //设置button的ID为comic_id
    self.rightbtn.tag = rightModel.comic_id.integerValue;
    [self.rightbtn addTarget:self action:@selector(showMore:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showMore:(UIButton *)btn {

    [self.delegate presentMoredetail:self WithID:btn.tag];
}
@end
