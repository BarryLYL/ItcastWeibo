//
//  IWStatusTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWStatusTool.h"
#import "IWAccountTool.h"
#import "IWAccount.h"
#import "IWHttpTool.h"
#import "MJExtension.h"
#import "IWStatus.h"
#import "IWStatusParam.h"
#import "IWStatusResult.h"

#import "IWStatusFrame.h"

#import "IWStatusCacheTool.h"

@implementation IWStatusTool

+ (void)moreStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    IWStatusParam *param = [[IWStatusParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;
    param.max_id = ID;
    
    // 加载缓存数据
    NSArray *statuses =  [IWStatusCacheTool statusesWithParam:param];
    if (statuses.count) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (IWStatus *status in statuses) {
            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
        // 不需要在发送请求
        return;
    }

    
    // 发送请求
    [IWHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 存储数据
        [IWStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        IWStatusResult *result = [IWStatusResult objectWithKeyValues:responseObject];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (IWStatus *status in result.statuses) {
            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)newStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    IWStatusParam *param = [[IWStatusParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;
    param.since_id = ID;
    
#warning  先从缓存中获取数据
//    NSArray *statuses =  [IWStatusCacheTool statusesWithParam:param];
//    if (statuses.count) {
//        
//        NSMutableArray *arrM = [NSMutableArray array];
//        for (IWStatus *status in statuses) {
//            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
//            statusF.status = status;
//            [arrM addObject:statusF];
//        }
//        if (success) {
//            success(arrM);
//        }
//        
//        // 不需要在发送请求
//        return;
//    }
    
    
    // 发送请求
    [IWHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        
#warning  存储数据
        [IWStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
        
        IWStatusResult *result = [IWStatusResult objectWithKeyValues:responseObject];
        
        NSDictionary *plist = result.keyValues;
        [plist writeToFile:@"/Users/yuanzheng/Desktop/status.plist" atomically:YES];
        
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (IWStatus *status in result.statuses) {
            IWStatusFrame *statusF = [[IWStatusFrame alloc] init];
            statusF.status = status;
            [arrM addObject:statusF];
        }
        if (success) {
            success(arrM);
        }

        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}


@end
