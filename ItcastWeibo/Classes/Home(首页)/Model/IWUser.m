//
//  IWUser.m
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWUser.h"

@implementation IWUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
