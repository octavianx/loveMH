//
//  MHScreenshotView.h
//  MH漫画控
//
//  Created by mis on 15/10/30.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHDetailModel.h"
@class MHScreenshotView;
@protocol MHScreenshotViewChickDelegate<NSObject>

- (void)jujiBtnClick:(MHScreenshotView *)controller withHiden:(BOOL)ishiden;


@end
@interface MHScreenshotView : UIView

@property (nonatomic,strong)NSArray *screenshot;

@property (nonatomic,weak)id<MHScreenshotViewChickDelegate>delegte;

@property(nonatomic,strong)NSArray *chapters;



+(instancetype)screenView;



@end
