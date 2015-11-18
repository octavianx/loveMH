//
//  MHContentViewModel.h
//  MHK
//
//  Created by mis on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseViewModel.h"
#import "MHContentNetManager.h"
@interface MHContentImgaeViewModel : BaseViewModel
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic)NSInteger rowNum;
- (void)getDataWith:(NSString *)name chpate_id:(NSInteger)ID completionHandle:(void(^)(NSError *error))comlepte;
- (NSURL *)urlForRow:(NSInteger)row;
@end
