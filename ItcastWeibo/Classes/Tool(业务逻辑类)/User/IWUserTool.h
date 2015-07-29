//
//  IWUserTool.h
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWUser,IWUserUnreadResult;
@interface IWUserTool : NSObject

+ (void)userInfoDidsuccess:(void (^)(IWUser *user))success failure:(void (^)(NSError *error))failure;

+ (void)unreadCountDidsuccess:(void (^)(IWUserUnreadResult *user))success failure:(void (^)(NSError *error))failure;

@end
