//
//  IWComposeToolBar.h
//  ItcastWeibo
//
//  Created by yz on 14/11/15.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    IWComposeToolBarButtonTypeCamera,
    IWComposeToolBarButtonTypeMention,
    IWComposeToolBarButtonTypeTrend,
    IWComposeToolBarButtonTypeEmoticon,
    IWComposeToolBarButtonTypeKeyboard
} IWComposeToolBarButtonType;
@class IWComposeToolBar;
@protocol IWComposeToolBarDelegate <NSObject>

@optional
- (void)toolBar:(IWComposeToolBar *)toolBar didClickType:(IWComposeToolBarButtonType)type;

@end

@interface IWComposeToolBar : UIView

@property (nonatomic, weak) id<IWComposeToolBarDelegate> delegate;

@end
