//
//  IWGroupItem.h
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWGroupItem : NSObject

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@end
