//
//  MHRecommendCell.m
//  MH漫画控
//
//  Created by mis on 15/11/6.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHRecommendCell.h"
#import "MHRecommendModel.h"
@interface MHRecommendCell ()


@property(nonatomic,strong)UIScrollView *scrollView;

@end
@implementation MHRecommendCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifie]) {
        self.scrollView = [UIScrollView new];
        [self.contentView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        UILabel *label = [UILabel new];
        label.text = @"相关漫画";
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
        }];
    }
        return self;
}

- (void)setRecommends:(NSMutableArray *)recommends {
    _recommends = recommends;
    NSInteger count = recommends.count;
    UIImageView *lastView = nil;
    for (int i = 0; i < count; i ++) {
        MHRecommendModel *recommed = recommends[i];
        UIImageView *coverimage = [UIImageView new];
        [coverimage setImageWithURL:[NSURL URLWithString:recommed.comic_cover] placeholderImage:[UIImage imageNamed:@"errorPage"]];
        [self.scrollView addSubview:coverimage];
        if (lastView == nil) {
            [coverimage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.scrollView.mas_left).mas_equalTo(10);
                make.top.mas_equalTo(30);
                make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-30);
                make.width.mas_equalTo(100);
            }];
        }else {
            [coverimage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10);
                make.top.mas_equalTo(30);
                make.bottom.mas_equalTo(self.mas_bottom).mas_equalTo(-30);
                make.width.mas_equalTo(100);
                
            }];
        }
        UILabel *textLabel = [UILabel new];
        textLabel.text = recommed.comic_name;
        textLabel.font = [UIFont systemFontOfSize:12];
        [self.scrollView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(coverimage.mas_bottom).mas_equalTo(5);
            make.left.mas_equalTo(coverimage.mas_left).mas_equalTo(0);
        }];
        
        lastView = coverimage;
    }
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.scrollView.mas_right).mas_equalTo(-10);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
