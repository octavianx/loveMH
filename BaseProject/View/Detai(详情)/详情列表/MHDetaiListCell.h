//
//  MHDetaiListCell.h
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHDetailListModel.h"
@class MHDetaiListCell;
@protocol MHDetaiListBtnDelegate <NSObject>

- (void)presentMoredetail:(MHDetaiListCell *)cell WithID:(NSInteger)ID;

@end


@interface MHDetaiListCell : UITableViewCell

@property(nonatomic,strong)MHDetailListObjectModel *leftModel;

@property(nonatomic,strong)MHDetailListObjectModel *rightModel;


@property(nonatomic,weak)id<MHDetaiListBtnDelegate> delegate;


@end
