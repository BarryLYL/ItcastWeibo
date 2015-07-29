//
//  IWSearchBar.m
//  ItcastWeibo
//
//  Created by yz on 14/11/6.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWSearchBar.h"

@implementation IWSearchBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder =  @"大家都在搜：减肥暴力锁屏";
        self.font = [UIFont systemFontOfSize:13];
        self.background =[UIImage resizableWithImageName:@"searchbar_textfield_background"];
        
        UIImageView *leftV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
        leftV.contentMode = UIViewContentModeCenter;
        leftV.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        self.leftView = leftV;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        

    }
    return self;
}
@end
