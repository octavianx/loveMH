//
//  BaseViewModel.h
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject

//当前的网络请求
@property(nonatomic,strong) NSURLSessionDataTask *dataTask;

- (void)cancelTask;  //取消任务

@end
