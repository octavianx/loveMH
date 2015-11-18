//
//  MHDetailModel.h
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"
@class MHDetailObjectModel;
@interface MHDetailModel : BaseModel
/**
 *  漫画的id 可以用来查询漫画内容
 */
@property(nonatomic,strong)NSNumber *ID;

/**
 *  漫画的标题
 */
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *enabled;
@property(nonatomic,strong)NSNumber *unit_price;
@property(nonatomic,strong)NSString *currency;
@property(nonatomic,strong)NSString *content_type;
@property(nonatomic,strong)MHDetailObjectModel *objects;
@property(nonatomic,strong)NSNumber *limit;
@property(nonatomic,strong)NSString *dt_release;
@property(nonatomic,strong)NSString *dt_expire;
@property(nonatomic,strong)NSString *stock;

/**
 *  类别，例如玄幻 热门推荐
 */
@property(nonatomic,strong)NSArray *tags;

/**
 *  收藏标签 首发 授权 玄幻等
 */
@property(nonatomic,strong)NSArray *marks;

@property(nonatomic,strong)NSNumber *seq;




@end

@interface MHDetailObjectModel : BaseModel

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

@interface MHDetailScreenshotModel : BaseModel

@property(nonatomic,strong)NSNumber *seq;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *url;

@property(nonatomic,strong)NSNumber *ID;

@property(nonatomic,strong)NSNumber *is_master;
@property(nonatomic,strong)NSString *thumbnail;

@end

@interface MHDetailResourcesModel : BaseModel




@end

@interface  MHDetailTagsModel : BaseModel

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSNumber *seq;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSNumber *is_master;
@property(nonatomic,strong)NSString *slug;

@end

@interface MHDetailMarksModel : BaseModel

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSNumber *seq;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSString *color;
@property(nonatomic,strong)NSNumber *is_master;
@property(nonatomic,strong)NSString *slug;

@end


















