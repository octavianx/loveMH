//
//  MHBannerCoverModel.h
//  MH漫画控
//
//  Created by mis on 15/10/31.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@interface MHBannerCoverModel : BaseModel

@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *image_set;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSNumber *height;
@property(nonatomic,strong)NSNumber *width;
@property(nonatomic,strong)NSNumber *size;
@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSString *dt_created;
@property(nonatomic,strong)NSString *dt_updated;


@end
