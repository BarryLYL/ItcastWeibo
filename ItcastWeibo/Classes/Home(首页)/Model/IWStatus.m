//
//  IWStatus.m
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWStatus.h"
#import "MJExtension.h"
#import "IWPhoto.h"
#import "NSDate+MJ.h"
@implementation IWStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[IWPhoto class]};
    
}


/*
 去年:
 2013-01-11 yyyy-MM-dd
 
 判断是否是今年
 今年:
 一分钟之内 刚刚
 一小时之内 多少分钟前
 24小时以内 多少小时
 昨天：  昨天 13：22  昨天：HH:mm
 前天   10-1 13：22  MM-dd HH:mm
 
 
 */
- (NSString *)created_at
{
    
//    NSLog(@"%@",_created_at);
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
#warning 真机必须加上这句话，否则转换不成功，必须告诉日期格式的区域，才知道怎么解析
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    // 获取微博创建时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    if ([createDate isThisYear]) { // 判断是否今年
        
        if ([createDate isToday]) { // 今天
            
            // 获取时间差
            NSDateComponents *cmp =  [createDate deltaWithNow];
            
            if (cmp.hour >= 1) { // 至少1小时
                return [NSString stringWithFormat:@"%d小时前",cmp.hour];
            }else if (cmp.minute > 1){ // 1~60分钟内发的
                return [NSString stringWithFormat:@"%d分钟前",cmp.minute];
            }else{
                return @"刚刚";
            }

            
        }else if ([createDate isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            
            return [fmt stringFromDate:createDate];
            
        }else{ // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            
            return [fmt stringFromDate:createDate];
        }
        
        
    }else{ // 不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd";
        
        return [fmt stringFromDate:createDate];
    }
    
    
}

- (void)setSource:(NSString *)source
{
    // <a href="http://app.weibo.com/t/feed/5yiHuw" rel="nofollow">iPhone 6 Plus</a>
    // <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    
    if ([source isEqualToString:@""]) return;
    
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + 1];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    

    
    _source = [NSString stringWithFormat:@"来自%@",source];
}

@end
