//
//  IWRetweetedView.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//
#import "IWStatus.h"
#import "IWStatusFrame.h"
#import "IWUser.h"
#import "IWRetweetedView.h"
#import <objc/message.h>

#import "IWPhotosView.h"

@interface IWRetweetedView ()

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak)  UILabel *textLabel;

@property (nonatomic, weak)  IWPhotosView *photosView;
@end

@implementation IWRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllSubviews];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableWithImageName:@"timeline_retweet_background"];


    }
    return self;
}

- (void)setUpAllSubviews
{
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = IWColor(85, 105, 144);
    _nameLabel = nameLabel;
    nameLabel.font = IWNameFont;
    [self addSubview:nameLabel];
    
    // 内容
    UILabel *textLabel = [[UILabel alloc] init];
    _textLabel.font = IWTextFont;
    _textLabel = textLabel;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    
    // 配图
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;

}




- (void)setStatusF:(IWStatusFrame *)statusF
{
    _statusF = statusF;
    IWStatus *s = statusF.status;
    
    self.frame = statusF.retweetedViewF;
    
    // 昵称
    _nameLabel.text = [NSString stringWithFormat:@"@%@",s.retweeted_status.user.name];
    _nameLabel.frame = statusF.retweetNameViewF;
    
    // 内容
    _textLabel.text= s.retweeted_status.text;
    _textLabel.frame = statusF.retweetTextViewF;
    
    // 配图
    if (s.retweeted_status.pic_urls.count) { // 有配图
        _photosView.pic_urls = s.retweeted_status.pic_urls;
        _photosView.frame = statusF.retweetPhotosViewF;
        _photosView.hidden = NO;
    }else{
        _photosView.hidden = YES;
    }
    
}

@end
