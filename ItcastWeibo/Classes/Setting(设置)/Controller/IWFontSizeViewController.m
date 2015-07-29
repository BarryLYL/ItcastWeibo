//
//  IWFontSizeViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWFontSizeViewController.h"
#import "IWGroupItem.h"
#import "IWCheakItem.h"

@interface IWFontSizeViewController ()

@property (nonatomic, strong) IWCheakItem *selCheakItem;

@end

@implementation IWFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    
}

- (void)setUpSelItem:(IWCheakItem *)item
{
     NSString *fontSizeStr =  [IWUserDefaults objectForKey:IWFontSizeKey];
    if (fontSizeStr == nil) {
        [self selItem:item];
        return;
    }
    
    for (IWGroupItem *group in self.groups) {
        for (IWCheakItem *item in group.items) {
            if ( [item.title isEqualToString:fontSizeStr]) {
                [self selItem:item];
            }
           
        }
        
    }
}

- (void)setUpGroup0
{
   
    
    // 大
    IWCheakItem *big = [IWCheakItem itemWithTitle:@"大"];
    __weak typeof(self) vc = self;
    big.option = ^{
        [vc selItem:big];
    };
    
    // 中
    IWCheakItem *middle = [IWCheakItem itemWithTitle:@"中"];
    
    middle.option = ^{
         [vc selItem:middle];
    };
    _selCheakItem = middle;
    // 小
    IWCheakItem *small = [IWCheakItem itemWithTitle:@"小"];
    small.option = ^{
        [vc selItem:small];
    };
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.headerTitle = @"上传图片质量";
    group.items = @[big,middle,small];
    [self.groups addObject:group];
    
    // 默认选中item
    [self setUpSelItem:middle];

}

- (void)selItem:(IWCheakItem *)item
{
    _selCheakItem.cheak = NO;
    item.cheak = YES;
    _selCheakItem = item;
    [self.tableView reloadData];
    
    
    // 存储
    [IWUserDefaults setObject:item.title forKey:IWFontSizeKey];
    [IWUserDefaults synchronize];
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:IWFontSizeChangeNote object:nil userInfo:@{IWFontSizeKey:item.title}];
    
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
