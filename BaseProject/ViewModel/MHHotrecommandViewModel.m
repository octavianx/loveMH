//
//  MHHotrecommandViewModel.m
//  MH漫画控
//
//  Created by mis on 15/10/26.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHotrecommandViewModel.h"
@interface MHHotrecommandViewModel ()



@end

@implementation MHHotrecommandViewModel
- (NSMutableArray *)objects {
    if (!_objects) {
        _objects = [NSMutableArray new];
    }
    return _objects;
}
- (void)getDataCompleteHandle:(void(^)(NSError *error))complete {
    NSString *type = @"hotrecommend";
    [MHHotrecommendNetManager getHotrecommend:type completionHandle:^(NSMutableArray *models, NSError *error) {
        [self.objects removeAllObjects];
        for (MHHotrecommendModel *model in models) {
            if (model.objects == nil) {
                DDLogVerbose(@"服务器传回空数值");
                continue;
            }
            [self.objects addObject:model.objects];
        }
        complete(error);
        
    }];
}
- (NSURL *)coverIconForNum:(NSInteger)Num {
    MHHotrecommendObject *object = self.objects[Num];
    return [NSURL URLWithString:object.comic_cover];
}

- (NSString *)titleForNum:(NSInteger)Num {
     MHHotrecommendObject *object = self.objects[Num];
    return object.comic_name;
}

- (NSString *)authorForNum:(NSInteger)Num {
    MHHotrecommendObject *object = self.objects[Num];
    return object.comic_author;
    
}


@end
