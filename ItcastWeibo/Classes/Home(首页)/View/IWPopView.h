//
//  IWPopView.h
//  ItcastWeibo
//
//  Created by yz on 14/11/5.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWPopView;

@protocol IWPopViewDelegate <NSObject>

@optional
- (void)popViewDidDismiss:(IWPopView *)popView;

@end

@interface IWPopView : UIView

+ (instancetype)popView;

- (void)showInRect:(CGRect)rect;

@property (nonatomic, weak) id<IWPopViewDelegate> delegate;

@property (nonatomic, weak) UIView *contentView;

@end
