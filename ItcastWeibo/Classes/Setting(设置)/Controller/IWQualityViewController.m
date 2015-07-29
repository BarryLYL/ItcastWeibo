//
//  IWQualityViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWQualityViewController.h"
#import "IWGroupItem.h"
#import "IWCheakItem.h"
#import "IWProfileCell.h"
@interface IWQualityViewController ()

@property (nonatomic, strong) IWCheakItem *selUploadItem;
@property (nonatomic, strong) IWCheakItem *selDoloadItem;

@end

@implementation IWQualityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加第0组
    [self setUpGroup0];
    
    // 添加第1组
    [self setUpGroup1];
    
}

- (void)setUpGroup0
{
    // 高清
      IWCheakItem *high = [IWCheakItem itemWithTitle:@"高清"];
    high.subTitle = @"建议在Wifi或3G网络使用";
    __weak typeof(self) vc = self;
    high.option = ^{
        [vc selUploadItem:high];
    };
    
    // 普通
     IWCheakItem *normal = [IWCheakItem itemWithTitle:@"普通"];
    normal.subTitle = @"上传速度快，省流量";
    
    normal.option = ^{
        [vc selUploadItem:normal];
    };
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.headerTitle = @"上传图片质量";
    group.items = @[high,normal];
    [self.groups addObject:group];
    
    // 默认选中第0组的一行
    NSString *upload = [IWUserDefaults objectForKey:IWSelUploadKey];
    if (upload == nil) {
        [self selUploadItem:high];
        return;
    }
    for (IWCheakItem *item in group.items) {
        if ([item.title isEqualToString:upload]) {
            [self selUploadItem:item];
        }
    }
    
}


- (void)setUpGroup1
{
    // 高清
    IWCheakItem *high = [IWCheakItem itemWithTitle:@"高清"];
    high.subTitle = @"建议在Wifi或3G网络使用";
    __weak typeof(self) vc = self;
    high.option = ^{
        [vc selDoloadItem:high];
  
    };
    
    // 普通
    IWCheakItem *normal = [IWCheakItem itemWithTitle:@"普通"];
    normal.subTitle = @"下载速度快，省流量";
    normal.option = ^{
        [vc selDoloadItem:normal];
    };
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.headerTitle = @"下载图片质量";
    group.items = @[high,normal];
    [self.groups addObject:group];
    
    // 默认选中第0组的一行
    NSString *downLoad = [IWUserDefaults objectForKey:IWSelDownloadKey];
    if (downLoad == nil) {
        [self selDoloadItem:high];
        return;
    }
    
    for (IWCheakItem *item in group.items) {
        if ([item.title isEqualToString:downLoad]) {
            [self selDoloadItem:item];
        }
    }

    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWProfileCell *cell = [IWProfileCell cellWithTableView:tableView];
    
    // 获取模型
    IWGroupItem *groupItem = self.groups[indexPath.section];
    IWSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}
- (void)selUploadItem:(IWCheakItem *)item
{
    _selUploadItem.cheak = NO;
    item.cheak = YES;
    _selUploadItem = item;
    [self.tableView reloadData];
    
    // 数据存储
    [IWUserDefaults setObject:item.title forKey:IWSelUploadKey];
    [IWUserDefaults synchronize];
}

- (void)selDoloadItem:(IWCheakItem *)item
{
    _selDoloadItem.cheak = NO;
    item.cheak = YES;
    _selDoloadItem = item;
    [self.tableView reloadData];
    
    // 数据存储
    [IWUserDefaults setObject:item.title forKey:IWSelDownloadKey];
    [IWUserDefaults synchronize];
}

@end
