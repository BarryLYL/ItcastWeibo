//
//  IWNewFeatureCell.m
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWNewFeatureCell.h"
#import "IWTabBarController.h"
static NSString * const reuseIdentifier = @"Cell";
static UICollectionView *_collectionView = nil;
@interface IWNewFeatureCell()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) UIButton *shareBtn;
@property (nonatomic, weak) UIButton *startBtn;

@end

@implementation IWNewFeatureCell

- (UIButton *)shareBtn
{
    if (_shareBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn sizeToFit];
        btn.center = CGPointMake(self.width* 0.5, self.height * 0.75);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _shareBtn = btn;
    }
    return _shareBtn;
}

- (void)share:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (UIButton *)startBtn
{
    if (_startBtn == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        startBtn.center = CGPointMake(self.width* 0.5, self.height * 0.85);
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startBtn = startBtn;
    }
    return _startBtn;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView = imageView;
        [self addSubview:imageView];
    }
    return _imageView;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView.image = image;
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    // 注册UICollectionViewCell
    if (_collectionView == nil) {
        _collectionView = collectionView;
        [collectionView registerClass:[IWNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath pagecount:(NSInteger)pagecount
{
    if (indexPath.row == pagecount - 1) { // 最后一页
        // 添加分享
        [self shareBtn];
        // 添加开始微博
        [self startBtn];
    }
}

- (void)start
{
    // 进入首页
    IWTabBarController *tabBarVc = [[IWTabBarController alloc] init];
    
    IWKeyWindow.rootViewController = tabBarVc;
    
}



@end
