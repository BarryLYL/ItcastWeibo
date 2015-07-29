//
//  IWStatusCell.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWStatusCell.h"

#import "IWOriginalView.h"
#import "IWRetweetedView.h"
#import "IWToolBarView.h"

#import "IWStatus.h"
#import "IWStatusFrame.h"

@interface IWStatusCell ()

@property (nonatomic, weak) IWOriginalView *originalView;
@property (nonatomic, weak) IWRetweetedView *retweetedView;
@property (nonatomic, weak) IWToolBarView *toolBar;
@end

@implementation IWStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setUpAllSubviews];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setUpAllSubviews
{
    // 添加原创微博
    IWOriginalView *originalView = [[IWOriginalView alloc] init];
    [self.contentView addSubview:originalView];
    _originalView = originalView;
    
    // 添加转发微博
    IWRetweetedView *retweetedView = [[IWRetweetedView alloc] init];
    [self.contentView addSubview:retweetedView];
    _retweetedView = retweetedView;
    
    // 添加工具条
    IWToolBarView *toolBar = [[IWToolBarView alloc] init];
    
    [self.contentView addSubview:toolBar];
    _toolBar = toolBar;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    IWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[IWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setStatusF:(IWStatusFrame *)statusF
{
    _statusF = statusF;
    
    IWStatus *status = statusF.status;
    
    // 设置原创微博
    _originalView.statusF = statusF;
    
    if (status.retweeted_status) {
        
        // 设置转发微博
        _retweetedView.statusF = statusF;
        _retweetedView.hidden = NO;
    }else{
        _retweetedView.hidden = YES;
    }
    
    // 设置工具条的位置
    _toolBar.status = status;
    _toolBar.frame = statusF.toolBarViewF;
    
    
}

@end
