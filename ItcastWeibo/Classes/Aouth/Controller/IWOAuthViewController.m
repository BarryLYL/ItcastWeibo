//
//  IWOAuthViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/12.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWOAuthViewController.h"




#import "AFNetworking.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "IWGuideTool.h"

#import "MBProgressHUD+MJ.h"
#import "IWHttpTool.h"

@interface IWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation IWOAuthViewController

- (void)loadView{
    self.view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:IWResquestTokeURLStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    

    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlStr = request.URL.absoluteString;
    
    
    // 获取requestToken
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length > 0) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        [self accessTokenWithCode:code];
        return NO;
    }
    
    return YES;
   
}

/*
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 
 */

- (void)accessTokenWithCode:(NSString *)code
{
    // 获取accessToken
    [IWAccountTool accessTokenWithCode:code success:^(IWAccount *account) {
        // 保存账号
        [IWAccountTool saveAccount:account];
        
        // 选择跟控制器
        [IWGuideTool guideRootViewController:IWKeyWindow];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在登录ing....."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}




@end
