//
//  IWBasicSettingViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWBasicSettingViewController.h"
#import "IWGroupItem.h"
#import "IWSettingItem.h"
#import "IWArrowItem.h"
#import "IWBasicSettingCell.h"

@interface IWBasicSettingViewController ()

@end

@implementation IWBasicSettingViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = IWColor(211, 211, 211);
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     IWGroupItem *groupItem = self.groups[section];
    return groupItem.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
     IWGroupItem *groupItem = self.groups[section];
    return groupItem.footerTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    IWGroupItem *groupItem = self.groups[section];
    return groupItem.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IWBasicSettingCell *cell = [IWBasicSettingCell cellWithTableView:tableView];
    
    // 获取模型
    IWGroupItem *groupItem = self.groups[indexPath.section];
    IWSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取模型
    IWGroupItem *groupItem = self.groups[indexPath.section];
    IWSettingItem *item = groupItem.items[indexPath.row];
    
    if (item.option) {
        item.option();
        return;
    }
    
    
    if (item.descVc) {
        UIViewController *vc = [[item.descVc alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
