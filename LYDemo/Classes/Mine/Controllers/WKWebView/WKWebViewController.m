//
//  WKWebViewController.m
//  LYDemo
//
//  Created by liyang on 2018/2/3.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

#define URLString @"http://m.langfangtong.cn/activity/report"

@interface WKWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页";
    
    [self.view addSubview:self.webView];
    [self loadRequest];
}




#pragma mark - Private Methods

- (void)loadRequest
{
    //添加cookie，加载网页
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    [request addValue:[self getCookies] forHTTPHeaderField:@"Cookie"];
    [self.webView loadRequest:request];
}

- (NSMutableString *)getCookies
{
    //先取出容器中的cookie
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [cookieDic setObject:cookie.value forKey:cookie.name];
    }
    
    //cookie去重，重组
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
    for (NSString *key in cookieDic) {
        [cookieValue appendString:[NSString stringWithFormat:@"%@=%@;", key, cookieDic[key]]];
    }
    [cookieValue appendString:@"aid=7324"];
    
    return cookieValue;
}




#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    
    //WKWebView的cookie会出现丢失的问题，所以在此判断如果cookie丢失了就重新添加
    NSDictionary *headerFields = navigationAction.request.allHTTPHeaderFields;
    NSString *cookie = headerFields[@"Cookie"];
    NSLog(@"[cookie] = %@", cookie);
    if (cookie == nil) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:navigationAction.request.URL];
        [request addValue:[self getCookies] forHTTPHeaderField:@"Cookie"];
        [webView loadRequest:request];
        policy = WKNavigationActionPolicyCancel;
        
    } else {
        NSString *absoluteString = navigationAction.request.URL.absoluteString;
        NSLog(@"发送请求之前决定是否跳转：Action-clickSchem = %@", absoluteString);
        
        if ([absoluteString hasPrefix:@"lftapp://"]) {
            if ([absoluteString isEqualToString:@"lftapp://login"]) {
                [self showAlertControllerWithTitle:@"提示" message:@"未登录"];
            } else if ([absoluteString isEqualToString:@"lftapp://shopCart"]) {
                [self showAlertControllerWithTitle:@"提示" message:@"购物车"];
            } else if ([absoluteString hasPrefix:@"lftapp://tel"]) {
                [self showAlertControllerWithTitle:@"提示" message:@"打电话"];
            } else if ([absoluteString hasPrefix:@"lftapp://goodDetail"]) {
                [self showAlertControllerWithTitle:@"提示" message:@"商品详情"];
            }
        }
    }
    
    decisionHandler(policy);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"收到响应后，决定是否跳转：clickSchem = %@", navigationResponse.response.URL.absoluteString);
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}
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
    NSLog(@"页面加载完成, %@", webView.title);
    self.title = webView.title;
    //修改字体大小
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '300%'" completionHandler:nil];
    //修改字体颜色
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#222222'"completionHandler:nil];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"页面加载失败");
}




#pragma mark - Getters and Setters

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, kSCREEN_WIDTH, kSCREEN_HEIGHT-NAVBAR_HEIGHT)];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
