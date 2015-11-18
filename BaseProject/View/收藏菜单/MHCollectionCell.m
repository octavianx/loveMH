//
//  MHCollectionCell.m
//  MH漫画控
//
//  Created by mis on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHCollectionCell.h"
@interface MHCollectionCell ()

@property(nonatomic,strong)UIImageView *IconView;

@property(nonatomic,strong)UILabel *nameLb;

@property(nonatomic,strong)UILabel *authorLb;

@end

@implementation MHCollectionCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加右侧划出三个按钮
        NSMutableArray *btns = [NSMutableArray new];
        [btns sw_addUtilityButtonWithColor:[UIColor redColor] title:@"删除"];
        //这里使用带有参数width的方法，就不会出现iphone6出问题的现象了
        [self setRightUtilityButtons:btns WithButtonWidth:100];
        
        self.IconView = [UIImageView new];
        [self.contentView addSubview:self.IconView];
        [self.IconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(5);
            make.width.mas_equalTo(100);
        }];
        
        self.nameLb = [UILabel new];
        [self.contentView addSubview:self.nameLb];
        [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IconView.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(30);
        }];
        
        self.authorLb = [UILabel new];
        [self.contentView addSubview:self.authorLb];
        [self.authorLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(self.nameLb);
            make.top.mas_equalTo(self.nameLb.mas_bottom).mas_equalTo(10);
        }];
        
        
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;

    self.nameLb.text =dic[@"name"];
    
    [self.IconView setImageWithURL:[NSURL URLWithString:dic[@"cover"]] placeholderImage:[UIImage imageNamed:@"errorPage"]];
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(100);
//    }];
    
    if ([dic[@"author"] isEqualToString:@""]) {
        self.authorLb.text = @"暂无";
    }
    self.authorLb.text = [NSString stringWithFormat:@"作者：%@",dic[@"author"]];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


@end
