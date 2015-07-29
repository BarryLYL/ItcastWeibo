//
//  IWNewFeatureCell.h
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWNewFeatureCell : UICollectionViewCell


@property (nonatomic, copy) NSString *imageName;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

- (void)setIndexPath:(NSIndexPath *)indexPath pagecount:(NSInteger)pagecount;

@end
