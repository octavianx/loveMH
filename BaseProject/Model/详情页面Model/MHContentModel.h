//
//  MHContentModel.h
//  MH漫画控
//
//  Created by mis on 15/11/9.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class MHComtentResult,MHChapterlistModel;
@interface MHContentModel : BaseModel

@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, strong) MHComtentResult *result;

@property (nonatomic, copy) NSString *reason;


@end
@interface MHComtentResult : BaseModel

@property (nonatomic, copy) NSString *comicName;

@property (nonatomic, strong) NSArray<MHChapterlistModel *> *chapterList;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger limit;

@end

@interface MHChapterlistModel : BaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger ID;

@end

