//
//  IWStatusParam.h
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWStatusParam : NSObject

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) id max_id;
@property (nonatomic, strong) id since_id;
@property (nonatomic, strong) id count;

@end
