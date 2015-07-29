//
//  IWAccountTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWAccountTool.h"
#import "IWAccount.h"
#import "IWAccountParam.h"
#define IWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"account.data"]

#import "IWHttpTool.h"
#import "MJExtension.h"



@implementation IWAccountTool

+ (void)saveAccount:(IWAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:IWAccountFile];
}

+ (IWAccount *)account
{
    IWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:IWAccountFile];
    
    // 判断是否过期，过期就返回nil
    if ([account.expires_time compare:[NSDate date]] != NSOrderedDescending) { // 过期
        return nil;
    }
    
    return account;
}

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)(IWAccount *account))success failure:(void (^)(NSError *))failure
{
    // 拼接参数
    IWAccountParam *param = [[IWAccountParam alloc] init];
    param.client_id = IWAppKey;
    param.client_secret = IWAppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = IWRedirectUrl;
    
    // 发送请求
    [IWHttpTool post:IWAccessTokenUrl parameters:param.keyValues success:^(id responseObject) {
        IWAccount *account = [IWAccount accountWithDict:responseObject];
        
        if (success) {
            success(account);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

}

@end
