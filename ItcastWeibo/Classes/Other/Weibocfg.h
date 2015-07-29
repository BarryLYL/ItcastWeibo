//
//  Weibocfg.h
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

// extern声明一个变量，就会自动去查找，对应的只读变量的值
extern NSString *const IWAppKey;
extern NSString *const IWAppSecret;
extern NSString *const IWRedirectUrl;

extern NSString *const IWAccessTokenUrl;

/**
 *  登录网页URL
 *
 */
#define IWResquestTokeURLStr  [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",IWAppKey,IWRedirectUrl]
