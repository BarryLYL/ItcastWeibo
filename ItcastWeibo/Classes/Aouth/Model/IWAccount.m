//
//  IWAccount.m
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWAccount.h"

#define IWAccessTokenKey @"access_token"
#define IWExpiresInKey @"expires_in"
#define IWExpiresTimeKey @"expires_time"
#define IWUidKey @"uid"
#define IWNameKey @"name"

@implementation IWAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    IWAccount *account = [[self alloc] init];
    
    account.expires_in = dict[IWExpiresInKey];
    account.uid = dict[IWUidKey];
    account.access_token = dict[IWAccessTokenKey];
    

    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    NSDate *date = [NSDate date];
   _expires_time = [date dateByAddingTimeInterval:[expires_in longLongValue]];
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:IWAccessTokenKey];
    [aCoder encodeObject:_expires_in forKey:IWExpiresInKey];
    [aCoder encodeObject:_expires_time forKey:IWExpiresTimeKey];
    [aCoder encodeObject:_uid forKey:IWUidKey];
    [aCoder encodeObject:_name forKey:IWNameKey];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        _access_token = [aDecoder decodeObjectForKey:IWAccessTokenKey];
        _expires_time = [aDecoder decodeObjectForKey:IWExpiresTimeKey];
        _expires_in = [aDecoder decodeObjectForKey:IWExpiresInKey];
        _uid = [aDecoder decodeObjectForKey:IWUidKey];
        _name = [aDecoder decodeObjectForKey:IWNameKey];
        
    }
    
    return self;
}

@end
