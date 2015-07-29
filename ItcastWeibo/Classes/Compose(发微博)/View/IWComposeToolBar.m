//
//  IWComposeToolBar.m
//  ItcastWeibo
//
//  Created by yz on 14/11/15.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWComposeToolBar.h"
#define IWBtnCount 5
@interface IWComposeToolBar ()


@end

@implementation IWComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllBtns];
        
    }
    return self;
}
- (void)setUpAllBtns{
    
   // 相册
    [self setUpOneButton:[UIImage imageNamed:@"compose_camerabutton_background"] highImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"]];
    // 提及
    [self setUpOneButton:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]];
    // 热门
    [self setUpOneButton:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]];
    // 表情
    [self setUpOneButton:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    // 键盘
    [self setUpOneButton:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]];
    
    
}
- (void)setUpOneButton:(UIImage *)image highImage:(UIImage *)highImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = self.subviews.count;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}


- (void)btnClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(toolBar:didClickType:)]) {
        [_delegate toolBar:self didClickType:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = self.subviews.count;
    CGFloat x = 0;
    CGFloat w = self.width / IWBtnCount;
    CGFloat h = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *b = self.subviews[i];
        x = i * w;
        b.frame = CGRectMake(x, 0, w, h);
    }
    
}

@end
