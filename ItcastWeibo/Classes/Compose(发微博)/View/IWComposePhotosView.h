//
//  IWComposePhotosView.h
//  ItcastWeibo
//
//  Created by yz on 14/11/16.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWComposePhotosView : UIView

@property (nonatomic, strong) NSMutableArray *images;
- (void)addImage:(UIImage *)image;

@end
