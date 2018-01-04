//
//  WebViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/4.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "WebViewController.h"

#define URLString @"http://m.test.langfangtong.cn/activity/report"

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网页";
    
    [self.view addSubview:self.webView];
    [self loadRequest];
}




#pragma mark - private methods

- (void)loadRequest
{
    NSURL *URL = [NSURL URLWithString:URLString];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [URL host], NSHTTPCookieDomain,
                                                                 [URL path], NSHTTPCookiePath,
                                                                 @"aid",     NSHTTPCookieName,
                                                                 @"10277",    NSHTTPCookieValue, nil]];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}




#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"网页开始加载");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"网页加载完成 ✅");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"网页加载失败 ❎");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *clickSchem = [[request URL] absoluteString];
    NSLog(@"clickSchem == %@", clickSchem);
    
    return YES;
}



#pragma mark - Getters and Setters

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT)];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.backgroundColor = WHITECOLOR;
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}

@end
