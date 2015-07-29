//
//  IWUserUnreadResult.m
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWUserUnreadResult.h"

@implementation IWUserUnreadResult

- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount
{
    return self.messageCount + _follower  + _status;
}

@end
