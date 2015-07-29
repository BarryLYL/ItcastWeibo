//
//  IWCommonSettingViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWCommonSettingViewController.h"

#import "IWArrowItem.h"
#import "IWSwitchItem.h"
#import "IWGroupItem.h"

#import "IWFontSizeViewController.h"
#import "IWQualityViewController.h"
#import "UIImageView+WebCache.h"

@interface IWCommonSettingViewController ()
@property (nonatomic, weak) IWSettingItem *fontSize;
@end

@implementation IWCommonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
    // 添加第4组
    [self setUpGroup4];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange:) name:IWFontSizeChangeNote object:nil];

}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)fontSizeChange:(NSNotification *)notication
{
    _fontSize.subTitle = notication.userInfo[IWFontSizeKey];
    [self.tableView reloadData];
}

- (void)setUpGroup0
{
    // 阅读模式
    IWSettingItem *read = [IWSettingItem itemWithTitle:@"阅读模式"];
    read.subTitle = @"有图模式";
    
    // 字体大小
    IWSettingItem *fontSize = [IWSettingItem itemWithTitle:@"字体大小"];
    _fontSize = fontSize;
    NSString *fontSizeStr =  [IWUserDefaults objectForKey:IWFontSizeKey];
    if (fontSizeStr == nil) {
        fontSizeStr = @"中";
    }
    fontSize.subTitle = fontSizeStr;
    fontSize.descVc = [IWFontSizeViewController class];
    
    // 显示备注
    IWSwitchItem *remark = [IWSwitchItem itemWithTitle:@"显示备注"];

    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[read,fontSize,remark];
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    // 图片质量
    IWArrowItem *quality = [IWArrowItem itemWithTitle:@"图片质量" ];
    quality.descVc = [IWQualityViewController class];
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[quality];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 声音
    IWSwitchItem *sound = [IWSwitchItem itemWithTitle:@"声音" ];
    
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[sound];
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    // 多语言环境
    IWSettingItem *language = [IWSettingItem itemWithTitle:@"多语言环境"];
    language.subTitle = @"跟随系统";
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[language];
    [self.groups addObject:group];
}

- (void)setUpGroup4
{
    // 清空图片缓存
    IWArrowItem *clearImage = [IWArrowItem itemWithTitle:@"清空图片缓存"];
    CGFloat fileSize = [SDWebImageManager sharedManager].imageCache.getSize / 1024.0;
    clearImage.subTitle = [NSString stringWithFormat:@"%.fKB",fileSize];
    if (fileSize > 1024) {
     fileSize =   fileSize / 1024.0;
        clearImage.subTitle = [NSString stringWithFormat:@"%.1fM",fileSize];
    }
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    
    CGFloat size =  [self sizeWithFile:filePath];
    NSLog(@"%f",size);
    clearImage.option = ^{

        [[SDWebImageManager sharedManager].imageCache clearDisk];
        clearImage.subTitle = nil;
        [self.tableView reloadData];
        
//     NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//      NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
//
//        [self removeFile:filePath];

    };
    IWGroupItem *group = [[IWGroupItem alloc] init];
    group.items = @[clearImage];
    [self.groups addObject:group];
}

- (CGFloat)sizeWithFile:(NSString *)filePath
{
    CGFloat totalSize = 0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (isExists) {
        
        if (isDirectory) {
            
          NSArray *subPaths =  [mgr subpathsAtPath:filePath];

            for (NSString *subPath in subPaths) {
                NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
                
                BOOL isDirectory;
                [mgr fileExistsAtPath:fullPath isDirectory:&isDirectory];
                
                if (!isDirectory) { // 计算文件尺寸
                    NSDictionary *dict =  [mgr attributesOfItemAtPath:fullPath error:nil];
                
                    totalSize += [dict[NSFileSize] floatValue];;
                }
            }

            
            
        }else{
        
            NSDictionary *dict =  [mgr attributesOfItemAtPath:filePath error:nil];
            totalSize =  [dict[NSFileSize] floatValue];
            
        }
        
    }
    return totalSize;
}

- (void)removeFile:(NSString *)filePath
{
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}



@end
