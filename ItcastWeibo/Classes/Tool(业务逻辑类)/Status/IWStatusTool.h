//
//  IWStatusTool.h
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWStatusTool : NSObject

+ (void)newStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *error))failure;

+ (void)moreStatusesWithID:(id)ID success:(void (^)(NSArray *statusFrameArr))success failure:(void (^)(NSError *error))failure;

@end
