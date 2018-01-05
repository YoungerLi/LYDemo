//
//  WebViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/4.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

#define URLString @"http://m.langfangtong.cn/activity/report"

@interface WebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页";
    
    [self.view addSubview:self.webView];
    [self loadRequest];
}




#pragma mark - Private Methods

- (void)loadRequest
{
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [cookieDic setObject:cookie.value forKey:cookie.name];
    }
    NSLog(@"cookieDic = %@", cookieDic);
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    for (NSString *key in cookieDic) {
        [cookieValue appendString:[NSString stringWithFormat:@"%@=%@;", key, cookieDic[key]]];
    }
//    [cookieValue appendString:@"aid=14743"];
    
    NSLog(@"cookieValue = %@", cookieValue);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [request addValue:cookieValue forHTTPHeaderField:@"Cookie"];
    [self.webView loadRequest:request];
}




#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面开始加载");
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"内容开始返回");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面加载完成");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"页面加载失败");
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"decidePolicyForNavigationResponse");
    
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    NSLog(@"URL = %@", response.URL);
    NSLog(@"cookie = %@", cookies);
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}




#pragma mark - Getters and Setters

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT)];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.backgroundColor = WHITECOLOR;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
