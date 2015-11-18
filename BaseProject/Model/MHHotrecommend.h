//
//  MHHotrecommend.h
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"
@class MHHotrecommendObject,MHHotrecommendScreenshot,MHHotrecommendResources,MHHotrecommendSite;
@interface MHHotrecommendModel : BaseModel

@property(nonatomic,strong)NSString *content_type;
@property(nonatomic,strong)MHHotrecommendObject *objects;
@property(nonatomic,strong)NSNumber *seq;
//@property(nonatomic)BOOL *is_master;
//@property(nonatomic)BOOL *enabled;
@property(nonatomic,strong)NSString *dt_created;
@property(nonatomic,strong)NSString *dt_updated;

@end

@interface MHHotrecommendObject : BaseModel

@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSNumber *comic_id;
@property(nonatomic,strong)NSNumber *rating;
/**
 *  漫画描述
 */
@property(nonatomic,strong)NSString *desc;

@property(nonatomic,strong)NSArray *screenshot;

/**
 *  漫画作者
 */
@property(nonatomic,strong)NSString *comic_author;
@property(nonatomic,strong)NSString *comic_score;
/**
 *  漫画封面
 */
@property(nonatomic,strong)NSString *comic_cover;

@property(nonatomic,strong)NSString *authorized_resource_count;
@property(nonatomic,strong)NSString *next_update_date;
@property(nonatomic,strong)NSString *source_cover;

@property(nonatomic,strong)NSArray *resources;

@property(nonatomic,strong)NSString *last_update_date;
@property(nonatomic,strong)NSNumber *comic_score_vote;
@property(nonatomic,strong)NSString *comic_name;
@property(nonatomic,strong)NSNumber *unauthorized_resource_count;


@end

@interface MHHotrecommendScreenshot : BaseModel
@property(nonatomic,strong)NSNumber *seq;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSNumber *ID;
//@property(nonatomic)BOOL *is_master;
@property(nonatomic,strong)NSString *thumbnail;

@end

@interface MHHotrecommendResources : BaseModel
@property(nonatomic,strong)MHHotrecommendSite *site;
@property(nonatomic,strong)NSString *max_episode_name;
@property(nonatomic,strong)NSNumber *resource_id;


@end

@interface MHHotrecommendSite : BaseModel
@property(nonatomic,strong)NSNumber *is_authorized;
@property(nonatomic,strong)NSString *site_name;
@property(nonatomic,strong)NSNumber *site_id;
@property(nonatomic,strong)NSString *site_url;

@end
