//
//  MHTableViewCell.m
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHTableViewCell.h"
#import "MHHotrecommend.h"
#import "MHHomeCover.h"
#import "MHDetaiViewController.h"
@interface MHTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *backbtn;
@property (weak, nonatomic) IBOutlet UIButton *forawardbtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scorllView;

@end

@implementation MHTableViewCell


- (void)setObjects:(NSArray *)objects {
    _objects  = objects;
    MHHomeCover *lastView = nil;
    for (NSInteger i = 0 ; i < objects.count; i++) {
        MHHotrecommendObject *object = objects[i];
        MHHomeCover *coverVC = [MHHomeCover item];
        coverVC.titleLabel.text = object.comic_name;
        [coverVC.coverImage setImageWithURL:[NSURL URLWithString:object.comic_cover]];
        coverVC.authorlabel.text = object.comic_author;
        
        UIButton *btn = [[UIButton alloc]init];
        
        [coverVC addSubview:btn];
        
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(coverVC);
            make.height.mas_equalTo(100);
        }];
        btn.tag = object.comic_id.integerValue;
        [btn addTarget:self action:@selector(showDetaiView:) forControlEvents:UIControlEventTouchUpInside];

        [self.scorllView addSubview: coverVC];
        
        if (lastView == nil) {
            [coverVC mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.scorllView.mas_left).mas_equalTo(10);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(80);
            }];
        }else {
            [coverVC mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10);
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(80);
            }];
        }
        lastView = coverVC;
    }
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.scorllView.mas_right).mas_equalTo(-10);
    }];
    self.scorllView.showsHorizontalScrollIndicator = NO;
    self.scorllView.showsVerticalScrollIndicator = NO;
    
}
- (void)setImages:(NSArray *)images {
    _images = images;
    UIButton *lastView = nil;
    for ( NSInteger i = 0 ; i < images.count; i++) {
        
        if ( i != 4) {
            
            UIButton *btn = [[UIButton alloc]init];
            
            [self.scorllView addSubview:btn];
            
            if (lastView == nil) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.scorllView.mas_left).mas_equalTo(10);
                    make.top.mas_equalTo(20);
                    make.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(150);
                }];
            }else {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(lastView.mas_right).mas_equalTo(20);
                    make.top.mas_equalTo(20);
                    make.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(150);
                }];
            }
            lastView = btn;
            MHHomepageObjectModel *object = images[i];
            UILabel *label = [[UILabel alloc]init];
            [btn addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(10);
            }];
            label.text = object.name;
            label.textColor = [UIColor whiteColor];
            label.hidden = self.isShowlabel;
            btn.tag = i;
            [btn setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:object.image_url]];
            [btn addTarget:self action:@selector(OtherDetail:) forControlEvents:UIControlEventTouchUpInside];
        }
   
    }
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.scorllView.mas_right).mas_equalTo(-10);
    }];
    self.scorllView.showsHorizontalScrollIndicator = NO;
    self.scorllView.showsVerticalScrollIndicator = NO;
    

}

- (void)showDetaiView:(UIButton *)btn {
    DDLogVerbose(@"点击啦");
    [self.delegate cellButtnprestnView:self withID:btn.tag];
}
- (void)OtherDetail: (UIButton *)btn{
    
       MHHomepageObjectModel *object =self.images[btn.tag];
    [self.delegate cellBttonOtherPrestnView:self WithImageModel:object];
    
    
    DDLogVerbose(@"这个点击啦");
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)movebtn:(UIButton *)sender {
//    DDLogVerbose(@"点了退后");
//    self.scorllView.contentOffset = CGPointMake(0, 0);
}
- (IBAction)foraward:(UIButton *)sender {
//    self.scorllView.contentOffset  = CGPointMake(100, 0);
//    NSLog(@"点了前进");
}
- (void)setTarget:(id)target action:(SEL)action {
    [self.backbtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
}

@end
