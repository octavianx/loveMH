//
//  MHSearchBaseModel.h
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface MHSearchBaseModel : BaseModel

//@property(nonatomic,strong)NSString *term;
//@property(nonatomic,strong)NSNumber *score;
//@property(nonatomic,strong)NSNumber *uid;
//@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSNumber *comic_id;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSNumber *rating;
@property(nonatomic,strong)NSString *comic_author;
@property(nonatomic,strong)NSNumber *comic_score;
@property(nonatomic,strong)NSString *comic_cover;
@property(nonatomic,strong)NSNumber *authorized_resource_count;
@property(nonatomic,strong)NSNumber *next_update_date;
@property(nonatomic,strong)NSString *source_cover;
@property(nonatomic,strong)NSString *last_update_date;
@property(nonatomic,strong)NSNumber *comic_score_vote;
@property(nonatomic,strong)NSString *comic_name;
@property(nonatomic,strong)NSString *unauthorized_resource_count;

@end
