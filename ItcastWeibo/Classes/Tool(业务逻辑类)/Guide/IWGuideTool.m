//
//  IWGuideTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWGuideTool.h"
#define IWVersionKey @"version"

#import "IWNewFeatureController.h"
#import "IWTabBarController.h"

#define IWUserDefaults [NSUserDefaults standardUserDefaults]

@implementation IWGuideTool


+ (void)guideRootViewController:(UIWindow *)window
{
    // 判断是否有新版本
    // 获取之前的版本
    NSString *oldVersion = [IWUserDefaults objectForKey:IWVersionKey];
    // 获取当前版本
    NSString *verKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[verKey];
    
    if (![oldVersion isEqualToString:currentVersion]) { // 有新版本
        // 存储新版本
        [IWUserDefaults setObject:currentVersion forKey:IWVersionKey];
        [IWUserDefaults synchronize];
        
        IWNewFeatureController *newFeatureVc = [[IWNewFeatureController alloc] init];
        window.rootViewController = newFeatureVc;
    }else{
        
        IWTabBarController *tabBarVc = [[IWTabBarController alloc] init];
        window.rootViewController = tabBarVc;
    }
    
}

@end
