//
//  Common.h
//  ItcastWeibo
//
//  Created by yz on 14/11/13.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#define iOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
#define iOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
#define inch4 ([UIScreen mainScreen].bounds.size.height == 568)

#define IWKeyWindow [UIApplication sharedApplication].keyWindow

#define IWNavgationBarTitleFont [UIFont boldSystemFontOfSize:20]

#ifdef DEBUG
#define IWLog(...) NSLog(__VA_ARGS__)

#else

#define IWLog(...)
#endif

#define IWColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

/*******StatusCell ******/
#define IWCellMargin 10
#define IWNameFont [UIFont systemFontOfSize:15]
#define IWTimeFont [UIFont systemFontOfSize:12]
#define IWSourceFont [UIFont systemFontOfSize:12]
#define IWTextFont [UIFont systemFontOfSize:18]

/*settting*/
#define IWUserDefaults [NSUserDefaults standardUserDefaults]
#define IWFontSizeKey @"字号大小"

#define IWFontSizeChangeNote @"fontSiziChange"


#define IWSelDownloadKey @"selDownloadKey"
#define IWSelUploadKey @"selDownloadKey"
