//
//  MHDetailViewModel.h
//  MH漫画控
//
//  Created by mis on 15/10/28.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHDetailNetManager.h"
@interface MHDetailViewModel : BaseViewModel


/**
 *  具体信息模型
 */
@property(nonatomic,strong)MHDetailObjectModel *object;


/**
 *  屏幕图片模型
 */
@property(nonatomic,strong)NSArray *screenhot;


@property (nonatomic,strong)NSArray *marks;

-(void)getdataWith:(NSInteger)ID CompeltionHandel:(void(^)(NSError *error))complete;
-(void)getOtherObjectWith:(NSInteger)ID CompeltionHandel:(void(^)(NSError *error))complete;
@end
