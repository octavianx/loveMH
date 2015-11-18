//
//  AppDelegate.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"
#import "MHHotrecommend.h"
#import "MHHotrecommendNetManager.h"
#import "MHLeftSilderViewController.h"
#import "MHHomeController.h"
#import "RESideMenu.h"
@interface AppDelegate ()
@property (strong, nonatomic) UINavigationController *mainNav;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self initializeWithApplication:application];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    MHLeftSilderViewController *leftVC = [MHLeftSilderViewController new];
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MHHomeController *homeVC = [storyboard instantiateInitialViewController];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    RESideMenu *menu = [[RESideMenu alloc] initWithContentViewController:nav leftMenuViewController:leftVC rightMenuViewController:nil];
//    self.mainNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    

    _window.rootViewController = menu;
    
 

    return YES;
}

@end
