//
//  MHBannerModel.h
//  MHK漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"
@class MHBannerObjectModel;
@interface MHBannerModel : BaseModel
/**
 *  滚动条漫画ID
 */
@property(nonatomic,strong)NSNumber *ID;

/**
 *  滚动条漫画名称
 */
@property(nonatomic,strong)NSString *title;
/**
 * 滚动条漫画描述
 */
@property(nonatomic,strong)NSString *desc;
/**
 *   图片的url
 */
@property(nonatomic,strong)NSString *image_url;

@property(nonatomic,strong)NSNumber *seq;
/**
 *  是否授权
 */
@property(nonatomic)BOOL is_master;
/**
 * 时间
 */
@property(nonatomic,strong)NSString *dt_created;
@property(nonatomic,strong)NSString *dt_updated;
/**
 *  回传的漫画类型（滚动条的漫画）
 */
@property(nonatomic,strong)NSString *banner_type;
/**
 *
 */
@property(nonatomic,strong)NSNumber *image_set_id;

@property(nonatomic,strong)MHBannerObjectModel *objects;


@end

@interface MHBannerObjectModel : BaseModel

@property(nonatomic,strong)NSString *unauthorized_resource_count;
@property(nonatomic,strong)NSNumber *meta_id;
@property(nonatomic,strong)NSString *authorized_resource_count;


@end