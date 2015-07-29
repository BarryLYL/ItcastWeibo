//
//  IWOneViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWOneViewController.h"
#import "IWTwoViewController.h"
@interface IWOneViewController ()

@end

@implementation IWOneViewController
- (IBAction)jump2two:(id)sender {
    IWTwoViewController *two = [[IWTwoViewController alloc] init];
    
    [self.navigationController pushViewController:two animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"第一个控制器";
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
