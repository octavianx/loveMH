//
//  MHDetailListModel.h
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"
@class MHDetailListObjectModel;
@interface MHDetailListModel : BaseModel
@property (nonatomic,strong)MHDetailListObjectModel *objects;
@property (nonatomic,strong)NSString *content_type;


@end

@interface MHDetailListObjectModel : BaseModel

@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSNumber *comic_id;
@property(nonatomic,strong)NSNumber *rating;

@property(nonatomic,strong)NSString *desc;

@property(nonatomic,strong)NSArray *screenshot;

@property(nonatomic,strong)NSString *comic_author;
@property(nonatomic,strong)NSNumber *comic_score;
@property(nonatomic,strong)NSString *comic_cover;
@property(nonatomic,strong)NSNumber *authorized_resource_count;
@property(nonatomic,strong)NSNumber *next_update_date;
@property(nonatomic,strong)NSString *source_cover;
@property(nonatomic,strong)NSNumber *unauthorized_resource_count;
@property(nonatomic,strong)NSString *last_update_date;
@property(nonatomic,strong)NSNumber *comic_score_vote;
@property(nonatomic,strong)NSString *comic_name;

@property(nonatomic,strong)NSArray *resources;

@end

@interface MHDetailListScreenshotModel : BaseModel



@end

@interface MHDetailListreSourcesModel : BaseModel




@end

