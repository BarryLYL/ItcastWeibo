//
//  IWSettingViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWSettingViewController.h"
#import "IWBadgeItem.h"
#import "IWArrowItem.h"
#import "IWGroupItem.h"
#import "IWLabelItem.h"
#import "IWCommonSettingViewController.h"

@interface IWSettingViewController ()

@end

@implementation IWSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
}

- (void)setUpGroup0
{
    // 账号管理
    IWBadgeItem *account = [IWBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"8";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[account];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 提醒和通知
    IWArrowItem *notice = [IWArrowItem itemWithTitle:@"我的相册" ];
    // 通用设置
    IWArrowItem *setting = [IWArrowItem itemWithTitle:@"通用设置" ];
    setting.descVc = [IWCommonSettingViewController class];
    // 隐私与安全
    IWArrowItem *secure = [IWArrowItem itemWithTitle:@"隐私与安全" ];
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[notice,setting,secure];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 意见反馈
    IWArrowItem *suggest = [IWArrowItem itemWithTitle:@"意见反馈" ];
    // 关于微博
    IWArrowItem *about = [IWArrowItem itemWithTitle:@"关于微博"];
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[suggest,about];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 账号管理
    IWLabelItem *layout = [[IWLabelItem alloc] init];
    layout.text = @"退出当前账号";
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[layout];
    [self.groups addObject:group];
}

@end
