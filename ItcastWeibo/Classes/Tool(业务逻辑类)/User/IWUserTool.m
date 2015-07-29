//
//  IWUserTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWUserTool.h"
#import "IWHttpTool.h"
#import "IWUserParam.h"

#import "IWAccountTool.h"
#import "IWAccount.h"
#import "MJExtension.h"
#import "IWUser.h"
#import "IWUserUnreadResult.h"
@implementation IWUserTool

+ (void)userInfoDidsuccess:(void (^)(IWUser *))success failure:(void (^)(NSError *))failure
{
    
    // 拼接参数
    IWUserParam *param = [[IWUserParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;
    param.uid = [IWAccountTool account].uid;
    
    [IWHttpTool get:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        IWUser *user = [IWUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)unreadCountDidsuccess:(void (^)(IWUserUnreadResult *))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    IWUserParam *param = [[IWUserParam alloc] init];
    param.access_token = [IWAccountTool account].access_token;
    param.uid = [IWAccountTool account].uid;
    
    [IWHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        IWUserUnreadResult *userUnread = [IWUserUnreadResult objectWithKeyValues:responseObject];
        if (success) {
            success(userUnread);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
