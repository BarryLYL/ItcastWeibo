//
//  IWBasicSettingCell.h
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWSettingItem;

@interface IWBasicSettingCell : UITableViewCell

@property (nonatomic, strong) IWSettingItem *item;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)rowCount;

@end
