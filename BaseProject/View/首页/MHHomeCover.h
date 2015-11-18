//
//  MHHomeCover.h
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHHomeCover : UIView
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorlabel;


+ (instancetype)item ;


@end
