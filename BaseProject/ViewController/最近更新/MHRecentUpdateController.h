//
//  MHRecentUpdateController.h
//  MHK
//
//  Created by mis on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHRecentUpdateController : UIViewController

+ (UINavigationController *)defaultNav;

@end


@interface MHRecentUpdateCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *nameLb;
@property(nonatomic,strong)UIImageView *iconView;


@end