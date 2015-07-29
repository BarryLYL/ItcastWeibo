//
//  IWNewFeatureController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWNewFeatureController.h"
#import "IWNewFeatureCell.h"
#import <Availability.h>
#define IWNewFeatureCount 4

@interface IWNewFeatureController ()
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation IWNewFeatureController


- (instancetype)init
{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取消滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    
    // 添加padgeController
    [self setUpPadgeController];

}

- (void)setUpPadgeController
{
    
    UIPageControl *page = [[UIPageControl alloc] init];
    
    page.center = CGPointMake(self.view.center.x, self.view.height);
    page.numberOfPages = IWNewFeatureCount;
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor blackColor];
    _pageControl = page;
    [self.view addSubview:page];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / scrollView.width + 0.5;
    
    _pageControl.currentPage = page;
    
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return IWNewFeatureCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    IWNewFeatureCell *cell = [IWNewFeatureCell cellWithCollectionView:collectionView indexPath:indexPath];
    
    // Configure the cell
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    
#ifndef __IPHONE_8_0 // xcode6就不需要编译
    if (inch4) {
        imageName = [imageName stringByAppendingString:@"-568h"];
    }
#endif

    cell.imageName = imageName;
    
    [cell setIndexPath:indexPath pagecount:IWNewFeatureCount];
    
    return cell;
}



@end
