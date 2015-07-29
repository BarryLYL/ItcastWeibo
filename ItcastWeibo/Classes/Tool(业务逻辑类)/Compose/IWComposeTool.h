//
//  IWComposeTool.h
//  ItcastWeibo
//
//  Created by yz on 14/11/16.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWComposeTool : NSObject

+ (void)composeWithSatausText:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *error))failure;

+ (void)composeWithImage:(UIImage *)image status:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *error))failure;


@end
