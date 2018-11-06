//
//  WebViewController1.m
//  LYDemo
//
//  Created by liyang on 2018/8/8.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "WebViewController1.h"
#import "PointsViewController.h"

#define URLString @"http://m.langfangtong.cn/activity/report"

@interface WebViewController1 ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"18500070368";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(lookPoints)];
    [self.view addSubview:self.webView];
    [self loadRequest];
}




#pragma mark - Private Methods

- (void)loadRequest
{
    //清空cookie
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    //添加cookie
    NSURL *URL = [NSURL URLWithString:URLString];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys:
                                                               [URL host], NSHTTPCookieDomain,
                                                               [URL path], NSHTTPCookiePath,
                                                               @"aid",     NSHTTPCookieName,
                                                               @"7324",    NSHTTPCookieValue, nil]];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    //加载网址
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

- (void)lookPoints
{
    PointsViewController *VC = [[PointsViewController alloc] init];
    VC.aid = @"7324";
    VC.phone = @"18500070368";
    [self.navigationController pushViewController:VC animated:YES];
}




#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *absoluteString = request.URL.absoluteString;
    NSLog(@"absoluteString == %@", absoluteString);
    
    if ([absoluteString hasPrefix:@"lftapp://"]) {
        if ([absoluteString isEqualToString:@"lftapp://login"]) {
            [Tools showAlertViewOfSystemWithTitle:@"提示" andMessage:@"未登录"];
        } else if ([absoluteString isEqualToString:@"lftapp://shopCart"]) {
            [Tools showAlertViewOfSystemWithTitle:@"提示" andMessage:@"购物车"];
        } else if ([absoluteString hasPrefix:@"lftapp://tel"]) {
            [Tools showAlertViewOfSystemWithTitle:@"提示" andMessage:@"打电话"];
        } else if ([absoluteString hasPrefix:@"lftapp://goodDetail"]) {
            [Tools showAlertViewOfSystemWithTitle:@"提示" andMessage:@"商品详情"];
        }
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"页面开始加载");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"页面加载成功");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"页面加载失败");
}




#pragma mark - Getters

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT)];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.backgroundColor = WHITECOLOR;
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}

@end
