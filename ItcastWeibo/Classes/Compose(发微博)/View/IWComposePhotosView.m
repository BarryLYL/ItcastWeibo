//
//  IWComposePhotosView.m
//  ItcastWeibo
//
//  Created by yz on 14/11/16.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWComposePhotosView.h"

@interface IWComposePhotosView ()



@end

@implementation IWComposePhotosView
- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)addImage:(UIImage *)image{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = image;
    
    [self addSubview:imageV];
    [self.images addObject:image];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat imageWH = 100;
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    int cols = 3;
    int count = self.subviews.count;
    CGFloat rol = 0;
    CGFloat col = 0;
    for (int i = 0; i < count; i++) {
        UIImageView *imgV = self.subviews[i];
        col = i % cols;
        rol = i / cols;
        imageX = col * (imageWH + margin);
        imageY = rol * (imageWH + margin);
        imgV.frame = CGRectMake(imageX, imageY, imageWH, imageWH);
        
    }
    
}

@end
