//
//  IWAccountTool.h
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWAccount;
@interface IWAccountTool : NSObject

+ (void)saveAccount:(IWAccount *)account;

+ (IWAccount *)account;

+ (void)accessTokenWithCode:(NSString *)code success:(void (^)(IWAccount *account))success failure:(void (^)(NSError *))failure;

@end
