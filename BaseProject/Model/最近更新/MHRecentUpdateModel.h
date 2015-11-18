//
//  MHRecentUpdateModel.h
//  MHK
//
//  Created by mis on 15/11/12.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"


@interface MHRecentUpdateModel : BaseModel

@property(nonatomic,strong)NSString *comic_author;
@property(nonatomic,strong)NSString *comic_cover;
@property(nonatomic,strong)NSNumber *comic_id;
@property(nonatomic,strong)NSString *comic_name;
@property(nonatomic,strong)NSString *last_update_date;
@property(nonatomic,strong)NSString *next_update_date;
@property(nonatomic,strong)NSNumber *rating;
@property(nonatomic,strong)NSString *source_icon;
@property(nonatomic,strong)NSNumber *status;

@end