//
//  IWComposeTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/16.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWComposeTool.h"

#import "AFNetworking.h"

#import "IWAccount.h"
#import "IWAccountTool.h"
#import "IWHttpTool.h"
#import "IWComposeParam.h"
#import "MJExtension.h"
#import "IWUploadParam.h"

@implementation IWComposeTool

+ (void)composeWithImage:(UIImage *)image status:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    IWComposeParam *param = [[IWComposeParam alloc] init];
    
    param.status = status;
    param.access_token = [IWAccountTool account].access_token;
    
    IWUploadParam *uploadParam = [[IWUploadParam alloc] init];
    uploadParam.fileName = @"image.png";
    uploadParam.data = UIImagePNGRepresentation(image);
    uploadParam.paramName = @"pic";
    uploadParam.mineType = @"image/png";
    
    // 发送请求
    [IWHttpTool upload:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues uploadParam:uploadParam success:^{
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)composeWithSatausText:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    IWComposeParam *param = [[IWComposeParam alloc] init];
    
    param.status = status;
    param.access_token = [IWAccountTool account].access_token;
    
    // 发送请求
    [IWHttpTool post:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
