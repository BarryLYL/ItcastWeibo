//
//  IWUploadParam.h
//  ItcastWeibo
//
//  Created by yz on 14/11/16.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUploadParam : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *paramName;
@property (nonatomic, copy) NSString *mineType;



@end
