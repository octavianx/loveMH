//
//  MHScreenshotView.m
//  MH漫画控
//
//  Created by mis on 15/10/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHScreenshotView.h"
#import "MHContentModel.h"

@interface MHScreenshotView ()//<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *shorDesc;
@property (weak, nonatomic) IBOutlet UIButton *jujiBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
/**
 *  剧集tableView
 */
@property(nonatomic,strong)UITableView *tableView;



@end
@implementation MHScreenshotView
//- (UITableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kWindowW, kWindowH/1.1) style:UITableViewStylePlain];
//        [self addSubview:self.tableView];
//        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.jujiBtn.mas_bottom).mas_equalTo(20);
//            make.left.mas_equalTo(0);
//            make.width.mas_equalTo(0);
//            make.height.mas_equalTo(kWindowH);
//        }];
//        _tableView.backgroundColor = [UIColor redColor];
//        _tableView.hidden = YES;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        
//    }
//    return _tableView;
//}
- (void)setScreenshot:(NSArray *)screenshot {
    _screenshot = screenshot;
    UIImageView *lastView = nil;
    for (NSInteger i = 0;i<screenshot.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        
        MHDetailScreenshotModel *screenModel = screenshot[i];
        
        [imageView setImageWithURL:[NSURL URLWithString:screenModel.url] placeholderImage:[UIImage imageNamed:@"errorPage"]];
        [self.scrollview addSubview:imageView];
        if (lastView == nil) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(self.scrollview.mas_left).mas_equalTo(10);
                make.height.mas_equalTo(220);
                make.width.mas_equalTo(120);
                
            }];
        }else {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10);
                make.height.mas_equalTo(220);
                make.width.mas_equalTo(120);
            }];
        }
        
        lastView = imageView;
   }
    [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.scrollview.mas_right).mas_equalTo(-10);
    }];
    
    //设置按钮
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.shorDesc.layer.cornerRadius = 5;
    [self Button:self.shorDesc bgcolor:YES];
    self.shorDesc.selected = YES;
    self.jujiBtn.layer.cornerRadius = 5;
  

}
- (void)setChapters:(NSArray *)chapters {
    _chapters = chapters;
    
}
+ (instancetype)screenView {
    return [[NSBundle mainBundle] loadNibNamed:@"MHScreenshotView" owner:nil options:nil].firstObject;
}
#pragma mark-----tableView的datasource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.chapters.count;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    }
//    MHChapterlistModel *listModel = self.chapters[indexPath.row];
//    cell.textLabel.text = listModel.name;
//    return cell;
//}
- (void)Button:(UIButton *)btn bgcolor:(BOOL)select {
    
    btn.backgroundColor = select?[UIColor lightGrayColor]:[UIColor whiteColor];
}
- (IBAction)shorDesc:(UIButton *)sender {
    DDLogVerbose(@"点击了简介");
    self.tableView.hidden = YES;
    self.jujiBtn.selected = NO;
    
    [self Button:sender bgcolor:YES];
    [self Button:self.jujiBtn bgcolor:NO];
    
    sender.selected = !sender.selected;
     [self.delegte jujiBtnClick:self withHiden:YES];
    

}
- (IBAction)jujiBtn:(UIButton *)sender {
    DDLogVerbose(@"点击了剧集");
    self.shorDesc.selected = NO;
    self.tableView.hidden = sender.selected;
    
    [self Button:sender bgcolor:YES];
    [self Button:self.shorDesc bgcolor:NO];
    
    sender.selected = !sender.selected;

    [self.delegte jujiBtnClick:self withHiden:NO];
//    [self.tableView reloadData];
    
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//   [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.delegte MHScreentableView:nil didSelectAtIndexPath:indexPath];
//     
//}

@end
