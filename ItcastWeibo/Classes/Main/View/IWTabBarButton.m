//
//  IWTabBarButton.m
//  ItcastWeibo
//
//  Created by yz on 14/11/5.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWTabBarButton.h"

#import "IWBadgeView.h"

#define HMImageRadio 0.7
#define HMMargin 6

@interface IWTabBarButton ()

@property (nonatomic, weak) IWBadgeView *badgeView;

@end

@implementation IWTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
    }
    return self;
}

- (UIButton *)badgeView
{
    if (_badgeView == nil) {
        IWBadgeView *badgeView = [IWBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:badgeView];
        _badgeView = badgeView;
    }
    return _badgeView;
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    [self setTitle:item.title forState:UIControlStateNormal];
    
    self.badgeView.badgeValue = item.badgeValue;
    
    
    [_item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.badgeView.badgeValue = _item.badgeValue;
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    [self setTitle:_item.title forState:UIControlStateNormal];

}

- (void)dealloc
{
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
    [_item removeObserver:self forKeyPath:@"title"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.width;
    CGFloat btnH = self.height;
    CGFloat imageH = btnH * HMImageRadio;
    self.imageView.frame = CGRectMake(0, 0, btnW, imageH);
    
    CGFloat titleH = btnH - imageH;
    CGFloat titleY = imageH - 2;
    self.titleLabel.frame = CGRectMake(0, titleY, btnW, titleH);
    
    // 设置badgeView尺寸
    self.badgeView.x = self.width - self.badgeView.width - HMMargin;
    
    self.badgeView.y = 0;

    
}

- (void)setHighlighted:(BOOL)highlighted{}

@end
