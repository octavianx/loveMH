//
//  MHHomepageModel.h
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"
@class MHHomepageObjectModel;
@interface MHHomepageModel : BaseModel
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSString *display_type;

@property(nonatomic,strong)NSString *content_type;

@property(nonatomic,strong)NSArray *objects;

@property(nonatomic,strong)NSNumber *is_master;

@property(nonatomic,strong)NSNumber *seq;

@property(nonatomic,strong)NSNumber *enabled;
@property(nonatomic,strong)NSString *dt_created;
@property(nonatomic,strong)NSString *dt_updated;

@end

@interface MHHomepageObjectModel : BaseModel

@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *slug;
@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSNumber *seq;
@property(nonatomic,strong)NSNumber *is_master;
@property(nonatomic,strong)NSNumber *image_set_id;
@property(nonatomic,strong)NSString *subtitle;

@end
