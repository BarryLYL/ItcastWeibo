//
//  IWPhotosView.m
//  ItcastWeibo
//
//  Created by yz on 14/11/14.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWPhotosView.h"
#import "IWPhoto.h"

#import "IWPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define IWPhotoCount 9

const CGFloat photoMargin = 10;
const CGFloat photoWH = 70;


@implementation IWPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllSubviews];
        
    }
    return self;
}
- (void)setUpAllSubviews
{
    for (int i = 0; i < IWPhotoCount; i++) {
        IWPhotoView *imageV = [[IWPhotoView alloc] init];
        imageV.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    // 弹出相册时显示的第一张图片是点击的图片
    browser.currentPhotoIndex = tap.view.tag;
    NSMutableArray *photos = [NSMutableArray array];

    for (IWPhoto *photo in _pic_urls) {

        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        mjPhoto.url = photo.thumbnail_pic;
        mjPhoto.srcImageView = (UIImageView *)tap.view;

        [photos addObject:mjPhoto];
    }
       // 设置所有的图片。photos是一个包含所有图片的数组。
    browser.photos = photos;
    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    int photosCount = pic_urls.count;
    
    for (int i = 0; i < IWPhotoCount; i++) {
        IWPhotoView *imageV = self.subviews[i];
        
        if (i >= photosCount) { // 大于总的个数，就不需要显示
            imageV.hidden = YES;
        }else{
            IWPhoto *photo = self.pic_urls[i];
            imageV.photo = photo;

            imageV.hidden = NO;
        }
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int photosCount = _pic_urls.count;

    int cols = photosCount == 4?2:3;
    int col = 0;
    int rol = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < photosCount; i++) {
        col = i % cols;
        rol = i / cols;
        x = col * (photoMargin + photoWH);
        y = rol * (photoMargin + photoWH);
        UIImageView *imgV = self.subviews[i];
        imgV.frame = CGRectMake(x, y, photoWH, photoWH);
        
    }
    
}

+ (CGSize)photosSizeWithCount:(int)count
{
    int cols = count == 4?2:3;
    int rols = (count - 1) / cols + 1;
    
    CGFloat photosW = (cols - 1) * photoMargin + cols * photoWH;
    CGFloat photosH = (rols - 1) * photoMargin + rols * photoWH;
    
    return CGSizeMake(photosW, photosH);
    
}


@end
