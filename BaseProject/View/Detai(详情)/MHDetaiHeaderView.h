//
//  MHDetaiHeaderView.h
//  MH漫画控
//
//  Created by mis on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHDetailModel.h"
@interface MHDetaiHeaderView : UIView
+(instancetype)headerView;
@property(nonatomic,strong)MHDetailObjectModel *object;
@end
