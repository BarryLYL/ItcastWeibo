//
//  IWTabBar.h
//  ItcastWeibo
//
//  Created by yz on 14/11/4.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBar;

@protocol IWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(IWTabBar *)tabBar didSelectedIndex:(NSInteger)selectedIndex;
- (void)tabBarDidClickAddBtn:(IWTabBar *)tabBar;

@end

@interface IWTabBar : UIView


- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<IWTabBarDelegate> delegate;

@end
