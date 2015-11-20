//
//  MHLeftSilderViewController.m
//  MH漫画控
//
//  Created by mis on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHLeftSilderViewController.h"
#import "MHCollectionController.h"
#import "MHHistoryController.h"
#import "RESideMenu.h"
#import "MHHomeController.h"
#import "UMSocial.h"
#import "MHRecentUpdateController.h"
#import "MHPersonSetController.h"
//每卷按钮的宽和高
static CGFloat buttonH = 60;
static CGFloat buttonW = 60;
//每卷按钮之间的左右间距
static CGFloat buttonM = 20;
//每卷按钮的上下间距
static CGFloat buttonS = 20;
@interface MHLeftSilderViewController ()
/**
 *  毛玻璃
 */
@property (strong, nonatomic) UIVisualEffectView *EffectView;


@end

@implementation MHLeftSilderViewController
- (UIVisualEffectView *)EffectView {
    if (!_EffectView) {
        UIBlurEffect *effect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _EffectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    }
    return _EffectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //LeftMenuBK_iPhone

    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    NSLog(@"%f",self.view.bounds.size.height);
    imageview.image = [UIImage imageNamed:@"LeftMenuBK_iPhone"];
    [self.view addSubview:imageview];
    [imageview addSubview:self.EffectView];
    [self.EffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageview.mas_top).mas_equalTo(300);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    for (NSInteger i = 0 ; i < 8; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.x = (i % 3 + 1)  * buttonM + (i % 3) * buttonW;
        
        btn.y = (i / 3) * buttonH + (i / 3 + 1) * buttonS + 300;
        
        btn.width = buttonW;
        btn.height = buttonH;
        btn.tag = i;
        [self.view addSubview:btn];
        
        NSString *imageName = [NSString stringWithFormat:@"leftIcon%ld",i+1];
        [btn setBackgroundImage:[self getCircularimagefrom:imageName withSize:CGSizeMake(60, 60)] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIImageView *UserImage = [[UIImageView alloc]init];
    [self.view addSubview:UserImage];
    [UserImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(120);
        make.top.mas_equalTo(120);
    }];
    UserImage.image = [self getCircularimagefrom:@"default_avatar" withSize:CGSizeMake(80, 80)];
    UIButton *UserBtn = [[UIButton alloc]init];
   
    [self.view addSubview:UserBtn];
    [UserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(120);
        make.top.mas_equalTo(120);
    }];


    [UserBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
}
    //使用第三方登陆QQ
- (void)login {
    DDLogVerbose(@"QQ登陆");
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
            }];
        }});
    
}

- (void)chick:(UIButton *)sender {
    
    if (sender.tag == 0) {
//        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[MHHomeController new]
//                                                     animated:YES];
         [self.sideMenuViewController setContentViewController:[MHHomeController defaultNavi]];
         [self.sideMenuViewController hideMenuViewController];
    }
    
    if (sender.tag == 1) {
        DDLogVerbose(@"点击了最近更新按钮");
        [self.sideMenuViewController setContentViewController:[MHRecentUpdateController defaultNav] animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    
    if (sender.tag == 3) {
         DDLogVerbose(@"点击了收藏按钮");

        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MHCollectionController alloc] init]] animated:YES];
         [self.sideMenuViewController hideMenuViewController];
        
    }
    
    if (sender.tag == 4) {
        
        DDLogVerbose(@"点击了历史记录按钮");
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[MHHistoryController alloc] init]] animated:YES];
         [self.sideMenuViewController hideMenuViewController];
    }
    if (sender.tag == 7) {
        DDLogVerbose(@"点击了个人设置按钮");
        
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[MHPersonSetController new]] animated:YES];
        [self.sideMenuViewController hideMenuViewController];
        
        
    }
    
}
- (UIImage *)getCircularimagefrom:(NSString *)name withSize:(CGSize)size{
    UIImage *image = [UIImage imageNamed:name];
    //思路：通知系统，在内存中临时增加一个视图
    //在这个空白的视图中，通过绘制path和image
    //生成一个临时的剪切完呈圆形的图片
    //再将内存中这张临时绘制的图片赋值给imageView
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [path addClip];
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //就将刚刚在内存中临时绘制的视图保存成了一张图片
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImg;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
