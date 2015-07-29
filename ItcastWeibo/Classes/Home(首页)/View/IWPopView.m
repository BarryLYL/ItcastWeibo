//
//  IWPopView.m
//  ItcastWeibo
//
//  Created by yz on 14/11/5.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWPopView.h"

#define IWMarginX 5
#define IWMarginY 13
@interface IWPopView()

@property (nonatomic, weak) UIImageView *containView;

@end

@implementation IWPopView

- (UIImageView *)containView
{
    if (_containView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage resizableWithImageName:@"popover_background"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _containView = imageView;
    }
    return _containView;
}

+ (instancetype)popView
{
    IWPopView *p = [[IWPopView alloc] initWithFrame:IWKeyWindow.bounds];

    return p;
}

- (void)showInRect:(CGRect)rect
{
    self.containView.frame = rect;

    [IWKeyWindow addSubview:self];
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    [self.containView addSubview:_contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = IWMarginX;
    CGFloat y = IWMarginY;
    CGFloat w = _containView.width - IWMarginX * 2;
    CGFloat h = _containView.height - IWMarginY * 2;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(popViewDidDismiss:)]) {
        [_delegate popViewDidDismiss:self];
    }
}

@end

