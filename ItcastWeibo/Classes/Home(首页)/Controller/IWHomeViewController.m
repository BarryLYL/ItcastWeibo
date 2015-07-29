//
//  IWHomeViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/4.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWHomeViewController.h"
#import "IWTitleButton.h"
#import "IWPopView.h"
#import "IWPopViewController.h"

#import "IWOneViewController.h"

#import "IWStatus.h"

#import "IWUser.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh.h"

#import "IWStatusTool.h"
#import "IWUserTool.h"

#import "IWAccount.h"
#import "IWAccountTool.h"

#import "IWStatusCell.h"

#import "IWStatusFrame.h"




const int navHeight = 64;

@interface IWHomeViewController ()<IWPopViewDelegate>

@property (nonatomic, strong) NSMutableArray *statusFrameArr;
@property (nonatomic, strong) IWPopView *popView;
@property (nonatomic, weak) IWTitleButton *titleButton;

@property (nonatomic, strong) IWPopViewController *popVc;


@end

@implementation IWHomeViewController
- (NSMutableArray *)statusFrameArr
{
    if (_statusFrameArr == nil) {
        _statusFrameArr = [NSMutableArray array];
    }
    return _statusFrameArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航条的内容
    [self setUpNavBar];
    
    // 添加刷新控件
    [self setUpRefreshView];

    // 开始刷新
    [self.tableView headerBeginRefreshing];
    
    self.tableView.backgroundColor = IWColor(211, 211, 211);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (void)setUpRefreshView
{
    // 添加下拉刷新控件
    typeof(self) homeVc = self;
    [self.tableView addHeaderWithCallback:^{
        [homeVc loadNewStatuses];
    }];
    
    // 添加上拉加载更多
    [self.tableView addFooterWithCallback:^{
        [homeVc loadMoreStatuses];
    }];
}
- (void)loadMoreStatuses
{
    IWStatusFrame *statusF = [self.statusFrameArr lastObject];
    id maxID = nil;
    if (statusF.status.idstr) {
        maxID = @([statusF.status.idstr longLongValue] - 1);
    }

    [IWStatusTool moreStatusesWithID:maxID success:^(NSArray *statusFrameArr) {
        
        [self.statusFrameArr addObjectsFromArray:statusFrameArr];
        
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        
    }];
   
}

- (void)refresh
{
    [self.tableView headerBeginRefreshing];
}


- (void)loadNewStatuses
{
    IWStatusFrame *statusF = [self.statusFrameArr firstObject];
    id sinceID = nil;
    if (statusF.status.idstr) {
        sinceID = statusF.status.idstr;
    }
    [IWStatusTool newStatusesWithID:sinceID success:^(NSArray *statusFrameArr) {
        
        // 提示最新微博数据
        NSInteger count = statusFrameArr.count;
        [self showNewStatusesCount:count];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, count)];
        [self.statusFrameArr insertObjects:statusFrameArr atIndexes:indexSet];
        
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failure:^(NSError *error) {
        
    }];
    
}

// 显示最新微博数
- (void)showNewStatusesCount:(NSInteger)count
{
    if (count == 0) return;
    CGFloat labelH = 35;
    CGFloat labelW = self.view.width;
    CGFloat labelY = navHeight - labelH;
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, labelY, labelW, labelH)];
    
    statusLabel.text = [NSString stringWithFormat:@"%ld条新微博",count];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];

    [self.navigationController.view insertSubview:statusLabel belowSubview:self.navigationController.navigationBar];

    
    [UIView animateWithDuration:0.5 animations:^{
        
        statusLabel.transform = CGAffineTransformMakeTranslation(0, labelY);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            statusLabel.transform = CGAffineTransformIdentity;

        } completion:^(BOOL finished) {
            [statusLabel removeFromSuperview];
        }];
        
    }];
    
}


#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    // 创建cell
    IWStatusCell *cell = [IWStatusCell cellWithTableView:tableView];
    
    IWStatusFrame *statusF =  self.statusFrameArr[indexPath.row];
    
    cell.statusF = statusF;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWOneViewController *one = [[IWOneViewController alloc] init];
    one.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:one animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWStatusFrame *statusF =  self.statusFrameArr[indexPath.row];
    
    return statusF.cellHeight;
}

- (IWPopViewController *)popVc
{
    if (_popVc == nil) {
        IWPopViewController *pop = [[IWPopViewController alloc] init];
        _popVc = pop;

    }
    return _popVc;
}
- (IWPopView *)popView
{
    if (_popView == nil) {
        
        IWPopView *v = [IWPopView popView];
        v.delegate = self;
        _popView = v;
    }
    return _popView;
}

#pragma mark - 搭建界面
// 设置导航条
- (void)setUpNavBar
{
    UIBarButtonItem *friendsearch = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch)];
    self.navigationItem.leftBarButtonItem = friendsearch;
    
    UIBarButtonItem *pop = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    self.navigationItem.rightBarButtonItem = pop;
    
    
    
    // 设置titleView
    IWTitleButton *titleButton = [IWTitleButton buttonWithType:UIButtonTypeCustom];

    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _titleButton = titleButton;
    
    self.navigationItem.titleView = titleButton;
    
    // 获取标题
    NSString *screenName = [IWAccountTool account].name;
    
    if (screenName == nil) { // 没有标题
        // 获取微博昵称
        [IWUserTool userInfoDidsuccess:^(IWUser *user) {
            
            // 保存标题昵称
            IWAccount *account = [IWAccountTool account];
            account.name = user.name;
            [IWAccountTool saveAccount:account];
            
            // 设置标题按钮
            [titleButton setTitle:user.name forState:UIControlStateNormal];
            
        } failure:^(NSError *error) {
            
        }];
        
    }else{ // 有标题
        [titleButton setTitle:screenName forState:UIControlStateNormal];
    }

    
}

// 点击标题的时候调用
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    //  显示菜单
    CGFloat x = (self.view.width - 200) * 0.5;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - 9;
    
    self.popView.contentView = self.popVc.view;
    
    [self.popView showInRect:CGRectMake(x, y, 200, 200)];
    
}
// popView代理
- (void)popViewDidDismiss:(IWPopView *)popView
{
    _titleButton.selected = NO;
    _popView = nil;
}

- (void)friendsearch
{
    IWLog(@"friendsearch");
//    NSLog(@"friendsearch");
}

- (void)pop
{
    
}



@end
