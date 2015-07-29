//
//  IWHttpTool.h
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IWUploadParam;

@interface IWHttpTool : NSObject
+ (void)get:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)upload:(NSString *)URLString
  parameters:(id)parameters
          uploadParam:(IWUploadParam *)uploadParam
     success:(void (^)())success
     failure:(void (^)(NSError *error))failure;


@end
