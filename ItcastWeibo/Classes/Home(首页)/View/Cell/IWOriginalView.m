//
//  IWOriginalView.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWOriginalView.h"


#import "IWStatus.h"
#import "IWStatusFrame.h"
#import "IWUser.h"

#import "IWPhotosView.h"

#import "UIImageView+WebCache.h"

@interface IWOriginalView ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *sourceLabel;
@property (nonatomic, weak)  UILabel *textLabel;

@property (nonatomic, weak)  IWPhotosView *photosView;


@end

@implementation IWOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllSubviews];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizableWithImageName:@"timeline_card_top_background"];
    }
    return self;
}

- (void)setUpAllSubviews
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = IWNameFont;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    // 会员
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 微博时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = IWTimeFont;
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = IWSourceFont;
    sourceLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceLabel];
    _sourceLabel = sourceLabel;
    
    // 内容
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.numberOfLines = 0;
    textLabel.font = IWTextFont;
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    // 配图
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatusF:(IWStatusFrame *)statusF
{
    _statusF = statusF;
    
    self.frame = statusF.originalViewF;
    
    IWStatus *s = statusF.status;
    
    // 头像
    [_iconView sd_setImageWithURL:s.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    _iconView.frame = statusF.iconViewF;
    
    // 昵称
    _nameLabel.text = s.user.name;
    _nameLabel.frame = statusF.nameViewF;
    
    // 会员
    if (s.user.isVip) { // 是会员
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",s.user.mbrank];
        _vipView.image = [UIImage imageNamed:vipName];
        _vipView.frame = statusF.vipViewF;
        _vipView.hidden = NO;
        _nameLabel.textColor = [UIColor orangeColor];
    }else{
        _nameLabel.textColor = [UIColor blackColor];
        _vipView.hidden = YES;
    }
    
    // 时间frame
    CGFloat timeX = statusF.nameViewF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusF.nameViewF) ;
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
    timeDict[NSFontAttributeName] = IWTimeFont;
    CGSize timeSize = [s.created_at sizeWithAttributes:timeDict];
    _timeLabel.frame = (CGRect){{timeX,timeY},timeSize};

    // 微博时间
    _timeLabel.text = s.created_at;
    if ([s.created_at isEqualToString:@"刚刚"]) {
        _timeLabel.textColor = [UIColor orangeColor];
    }else{
        _timeLabel.textColor = [UIColor lightGrayColor];
    }
    
    // 来源
    _sourceLabel.text = s.source;
    
    // 来源frame
    CGFloat sourceX = CGRectGetMaxX(_timeLabel.frame) + IWCellMargin;
    CGFloat sourceY = timeY;
    NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
    sourceDict[NSFontAttributeName] = IWSourceFont;
    CGSize sourceSize = [s.source sizeWithAttributes:sourceDict];
     _sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    // 内容
    _textLabel.text= s.text;
    _textLabel.frame = statusF.textViewF;
    
    
    // 配图
    if (s.pic_urls.count) { // 有配图
        _photosView.pic_urls = s.pic_urls;
        _photosView.frame = statusF.photosViewF;
        _photosView.hidden = NO;
    }else{
        _photosView.hidden = YES;
    }
    
}

@end
