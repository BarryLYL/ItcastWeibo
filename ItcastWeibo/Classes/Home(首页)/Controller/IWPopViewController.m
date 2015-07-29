//
//  IWPopViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWPopViewController.h"

@interface IWPopViewController()

@property (nonatomic, strong) NSArray *datas;

@end

@implementation IWPopViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _datas = @[@"好友圈",@"我的微博",@"周边微博"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = _datas[indexPath.row];
    
    return cell;
}

@end
