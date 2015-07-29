//
//  IWSettingItem.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWSettingItem.h"

@implementation IWSettingItem

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image
{
    IWSettingItem *item = [[self alloc] init];
    item.image = image;
    item.title = title;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title
{
    IWSettingItem *item = [self itemWithTitle:title image:nil];
    return item;
}

@end
