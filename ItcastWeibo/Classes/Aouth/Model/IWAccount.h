//
//  IWAccount.h
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid	string	当前授权用户的UID。
 */

@interface IWAccount : NSObject<NSCoding>

/**
 *  获取授权后的access token
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  当前授权用户的UID
 */
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSDate *expires_time;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
