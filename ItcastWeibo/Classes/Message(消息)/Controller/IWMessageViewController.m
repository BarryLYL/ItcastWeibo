//
//  IWMessageViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/4.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWMessageViewController.h"

@interface IWMessageViewController ()

@end

@implementation IWMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *chat = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = chat;
}

@end
