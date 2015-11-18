//
//  MHHomeController.h
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHHomeController : UITableViewController
/*制作单例原因:侧边栏需要经常切换内容页，内容页不应该随着切换而被释放掉，每次切换的应该是同一个内存地址 */
+ (UINavigationController *)defaultNavi;
@end
