//
//  IWUser.h
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUser : NSObject

/**
 *  友好显示名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  用户头像地址
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;


@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
