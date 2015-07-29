//
//  IWStatusViewF.h
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IWStatus;
@interface IWStatusFrame : NSObject

/**
 *  原创微博Frame
 */
@property (nonatomic, assign) CGRect originalViewF;

/**
 *  转发微博Frame
 */
@property (nonatomic, assign) CGRect retweetedViewF;

/**
 *  工具条Frame
 */
@property (nonatomic, assign) CGRect toolBarViewF;


/** 原创微博所有子控件Frame */
/**
 *  原创头像frame
 */
@property (nonatomic, assign) CGRect iconViewF;

/**
 *  原创昵称frame
 */
@property (nonatomic, assign) CGRect nameViewF;
/**
 *  原创会员
 */
@property (nonatomic, assign) CGRect vipViewF;

/**
 *  原创时间frame
 */
@property (nonatomic, assign) CGRect timeViewF;
/**
 *  原创来源frame
 */
@property (nonatomic, assign) CGRect sourceViewF;
/**
 *  原创内容frame
 */
@property (nonatomic, assign) CGRect textViewF;


/**
 *  原创配图frame
 */
@property (nonatomic, assign) CGRect photosViewF;

/** 转发微博所有子控件Frame */
/**
 *  转发昵称frame
 */
@property (nonatomic, assign) CGRect retweetNameViewF;
/**
 *  转发内容frame
 */
@property (nonatomic, assign) CGRect retweetTextViewF;

/**
 *  转发配图frame
 */
@property (nonatomic, assign) CGRect retweetPhotosViewF;


@property (nonatomic, strong) IWStatus *status;

/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
