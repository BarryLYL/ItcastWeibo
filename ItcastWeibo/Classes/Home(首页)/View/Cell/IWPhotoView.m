//
//  IWPhoto.m
//  ItcastWeibo
//
//  Created by yz on 14/11/14.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWPhotoView.h"

#import "IWPhoto.h"
#import "UIImageView+WebCache.h"


@interface IWPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation IWPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (UIImageView *)gifView
{
    if (_gifView == nil) {
        UIImageView *gifV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        
        _gifView = gifV;
        
        [self addSubview:gifV];
    }
    return _gifView;
}

- (void)setPhoto:(IWPhoto *)photo
{
    _photo = photo;
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([_photo.thumbnail_pic.absoluteString hasSuffix:@".gif"]) { // gif图片
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}

@end
