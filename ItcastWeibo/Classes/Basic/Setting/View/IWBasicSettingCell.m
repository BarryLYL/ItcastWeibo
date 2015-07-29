//
//  IWBasicSettingCell.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWBasicSettingCell.h"
#import "IWSettingItem.h"
#import "IWArrowItem.h"
#import "IWSwitchItem.h"
#import "IWCheakItem.h"
#import "IWBadgeItem.h"
#import "IWBadgeView.h"
#import "IWLabelItem.h"

@interface IWBasicSettingCell ()

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *cheakView;
@property (nonatomic, strong) IWBadgeView *badgeView;
@property (nonatomic, weak) UILabel *labelView;


@end
@implementation IWBasicSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        _labelView = label;
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
        [self addSubview:_labelView];
    }
    return _labelView;
}
- (IWBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [[IWBadgeView alloc] init];
    }
    return _badgeView;
}
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchView;
}

- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        _cheakView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _cheakView;
}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    
    IWBasicSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;

}

- (void)setItem:(IWSettingItem *)item
{
    _item = item;
    
    // 设置数据
    [self setUpData];
    // 设置模型
    [self setUpRightView];
}

- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}

- (void)setUpRightView
{
    if ([_item isKindOfClass:[IWArrowItem class]]) { // 箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[IWSwitchItem class]]){ // 开关
        self.accessoryView = self.switchView;
        IWSwitchItem *switchItem = (IWSwitchItem *)_item;
        self.switchView.on = switchItem.on;

    }else if ([_item isKindOfClass:[IWCheakItem class]]){ // 打钩
        IWCheakItem *badgeItem = (IWCheakItem *)_item;
        if (badgeItem.cheak) {
            self.accessoryView = self.cheakView;
        }else{
            self.accessoryView = nil;
        }
    }else if ([_item isKindOfClass:[IWBadgeItem class]]){
        IWBadgeItem *badgeItem = (IWBadgeItem *)_item;
        IWBadgeView *badge = self.badgeView;
        self.accessoryView = badge;
        badge.badgeValue = badgeItem.badgeValue;
    }else if ([_item isKindOfClass:[IWLabelItem class]]){
        IWLabelItem *labelItem = (IWLabelItem *)_item;
        UILabel *label = self.labelView;
        label.text = labelItem.text;
        
    }else{ // 没有
        self.accessoryView = nil;
        [_labelView removeFromSuperview];
        _labelView = nil;
    }
        
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)count
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
    if (count == 1) { // 只有一行
        bgView.image = [UIImage resizableWithImageName:@"common_card_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_background_highlighted"];
        
    }else if(indexPath.row == 0){ // 顶部cell
        bgView.image = [UIImage resizableWithImageName:@"common_card_top_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_top_background_highlighted"];
        
    }else if (indexPath.row == count - 1){ // 底部
        bgView.image = [UIImage resizableWithImageName:@"common_card_bottom_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_bottom_background_highlighted"];
        
    }else{ // 中间
        bgView.image = [UIImage resizableWithImageName:@"common_card_middle_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_middle_background_highlighted"];
    }

}

- (void)switchChange:(UISwitch *)switchView
{

    IWSwitchItem *switchItem = (IWSwitchItem *)_item;
    switchItem.on = switchView.on;
        
}


@end
