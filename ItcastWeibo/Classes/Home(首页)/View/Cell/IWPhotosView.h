//
//  IWPhotosView.h
//  ItcastWeibo
//
//  Created by yz on 14/11/14.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//  相册

#import <UIKit/UIKit.h>


@interface IWPhotosView : UIView

@property (nonatomic, strong) NSArray *pic_urls;

+ (CGSize)photosSizeWithCount:(int)count;

@end
