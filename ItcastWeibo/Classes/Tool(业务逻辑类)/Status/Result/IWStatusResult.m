//
//  IWStatusResult.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWStatusResult.h"
#import "MJExtension.h"
#import "IWStatus.h"
@implementation IWStatusResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[IWStatus class]};
}

@end
