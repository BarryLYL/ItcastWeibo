//
//  IWDiscoverViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/4.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWDiscoverViewController.h"
#import "IWSearchBar.h"

@interface IWDiscoverViewController ()

@end

@implementation IWDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航条内容
    [self setUpNavBar];
}

- (void)setUpNavBar
{
    // 搜索框
    IWSearchBar *searchBar = [[IWSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 32)];
    
    self.navigationItem.titleView = searchBar;
    
}

@end
