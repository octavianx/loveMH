//
//  MHDetaiHeaderView.m
//  MH漫画控
//
//  Created by mis on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetaiHeaderView.h"
@interface MHDetaiHeaderView ()<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *authorLB;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (weak, nonatomic) IBOutlet UILabel *updateLB;
@property (weak, nonatomic) IBOutlet UIButton *favrotie;

/**
 *  毛玻璃
 */
@property (strong, nonatomic) UIVisualEffectView *EffectView;

/**
 *  创建收藏文件的plist路径
 */
@property(nonatomic,strong)NSString *collectionPath;
/**
 *  plist文件中的总数组
 */

@property(nonatomic,strong)NSMutableArray *collectionArr;

@property(nonatomic,strong)MBProgressHUD *HUD;

@end
@implementation MHDetaiHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (MBProgressHUD *)HUD {
//    if (!_HUD) {
//        _HUD = [[MBProgressHUD alloc] initWithView:self];
//        [self addSubview:_HUD];
//        _HUD.mode = MBProgressHUDModeDeterminate;
//        _HUD.delegate = self;
//
//    }
//    return _HUD;
//}
- (NSMutableArray *)collectionArr {
    if (!_collectionArr) {
        _collectionArr = [NSMutableArray arrayWithContentsOfFile:self.collectionPath];
    }
    return _collectionArr;
}
- (NSString *)collectionPath {
    if (!_collectionPath) {
        _collectionPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _collectionPath = [_collectionPath stringByAppendingPathComponent:@"collection.plist"];
       // DDLogVerbose(@"收藏plist的路径是:%@",_collectionPath);
    }
    return _collectionPath;
}
- (UIVisualEffectView *)EffectView {
    if (!_EffectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _EffectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        
        
    }
    return _EffectView;
}
+(instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"MHDetailHeaderView" owner:nil options:nil].firstObject;
}
- (void)setObject:(MHDetailObjectModel *)object {
    _object = object;
    if (object == nil) {
        return;
    }
    [self.coverImage setImageWithURL:[NSURL URLWithString:object.comic_cover]];
    
    
    self.nameLB.text = object.comic_name;
    
    self.authorLB.text = object.comic_author;
    
    self.scoreLb.text = [NSString stringWithFormat:@"%.01f",object.comic_score.floatValue];
    if(object.last_update_date.length == 0){
        self.updateLB.text = @"暂无";
    } else {
        self.updateLB.text = object.last_update_date;
    }
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImageWithURL:[NSURL URLWithString:object.comic_cover]];
    imageView.frame = self.frame;
    
    self.EffectView.frame = self.frame;
    
    [imageView addSubview:self.EffectView];
    
    [self insertSubview:imageView atIndex:0];
    for (NSDictionary *p in self.collectionArr) {
        if ( [p[@"id"] isEqualToString:self.object.comic_id.stringValue]) {
            self.favrotie.selected = YES;
            return;
        }
    }


    
    
}
#pragma mark --- 收藏按钮
- (IBAction)collectionBtn:(UIButton *)sender {
    DDLogVerbose(@"点击了收藏");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.collectionPath]) {
        [fileManager createFileAtPath:self.collectionPath contents:nil attributes:nil];
    }
    self.collectionArr =[NSMutableArray mj_objectArrayWithFile:self.collectionPath];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:self.object.comic_id.stringValue forKey:@"id"];
    [dic setValue:self.object.comic_name forKey:@"name"];
    [dic setValue:self.object.comic_cover forKey:@"cover"];
    [dic setValue:self.object.comic_author forKey:@"author"];
   //如果一开始不是收藏状态
    if (self.favrotie.selected == NO) {

            [self.collectionArr insertObject:dic atIndex:0];
            
            [self.collectionArr writeToFile:self.collectionPath atomically:YES];
        
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:_HUD];
        _HUD.mode = MBProgressHUDModeDeterminate;
        _HUD.delegate = self;

        _HUD.labelText = @"收藏成功";
        
        // myProgressTask uses the HUD instance to update progress
        [_HUD showWhileExecuting:@selector(sleep) onTarget:self withObject:nil animated:YES];

    }else {//如果已经是收藏状态了，取消收藏
        NSInteger index = 0;
        for (NSDictionary *p in self.collectionArr) {
            if ( [p[@"id"] isEqualToString:self.object.comic_id.stringValue]) {
                index = [self.collectionArr indexOfObject:p];
                break;
            }
        }
        [self.collectionArr removeObjectAtIndex:index];
        [self.collectionArr writeToFile:self.collectionPath atomically:YES];
        
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:_HUD];
        _HUD.mode = MBProgressHUDModeDeterminate;
        _HUD.delegate = self;

        _HUD.labelText = @"取消成功";
        
        // myProgressTask uses the HUD instance to update progress
        [_HUD showWhileExecuting:@selector(sleep) onTarget:self withObject:nil animated:YES];

    }
    //改变btn的selct状态
       self.favrotie.selected = !sender.selected;

}
- (void)sleep {
    sleep(1);
}
@end
