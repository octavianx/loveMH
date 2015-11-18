//
//  MHResultDetailCell.h
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@interface MHResultDetailCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *CoverImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *authorLB;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

+(instancetype)ResutlDetailCell;
@end
