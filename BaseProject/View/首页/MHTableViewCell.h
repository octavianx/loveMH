//
//  MHTableViewCell.h
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHHomepageModel.h"
@class MHTableViewCell;
@protocol ButtunCheckDelegate<NSObject>
/**
 *  监听按钮的点击，弹出详情View
 */
-(void)cellButtnprestnView:(MHTableViewCell *)cell withID:(NSInteger)ID;
/**
 * 弹出详情listView
 */
-(void)cellBttonOtherPrestnView:(MHTableViewCell *)cell WithImageModel:(MHHomepageObjectModel *)imageModel;


@end
@interface MHTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray *objects;
@property(nonatomic,strong)NSArray *images;
//是否显示滚动栏的标签，如果自带文子，则不显示
@property(nonatomic)BOOL isShowlabel;

@property(nonatomic,weak)id<ButtunCheckDelegate>delegate;


@end
