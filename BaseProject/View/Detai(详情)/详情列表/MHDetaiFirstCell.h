//
//  MHDetaiFirstCell.h
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHDetaiFirstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
+(instancetype)DetailFirsCell;
@end
