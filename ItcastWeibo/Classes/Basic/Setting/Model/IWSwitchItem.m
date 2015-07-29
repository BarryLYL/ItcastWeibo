//
//  IWSwitchItem.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWSwitchItem.h"

@implementation IWSwitchItem

- (void)setOn:(BOOL)on
{
    _on = on;
    
    // 数据存储
    [IWUserDefaults setBool:on forKey:self.title];

}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    self.on = [IWUserDefaults boolForKey:title];
}

@end
