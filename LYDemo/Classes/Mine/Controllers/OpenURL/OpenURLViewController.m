//
//  OpenURLViewController.m
//  text
//
//  Created by Kosien on 17/1/17.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "OpenURLViewController.h"

@interface OpenURLViewController ()

@end

@implementation OpenURLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"跳转";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, kSCREEN_WIDTH-20, 50)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //跳转APP注意事项：
    //1、在将要跳转到的APP中TARGETS--info--URL Types中添加URL Schemes；
    //2、在本APP的info.plist中添加一个LSApplicationQueriesSchemes数组字段，把对方的APP的URL Schemes添加进去
}


- (void)click
{
    //跳转系统APP
//    NSURL *URL;
//    URL = [NSURL URLWithString:@"tel://1234567"];           //拨打电话
//    URL = [NSURL URLWithString:@"sms://1234567"];           //发送短信
//    URL = [NSURL URLWithString:@"http://www.baidu.com"];    //Safari
//    URL = [NSURL URLWithString:@"mailto://admin@abt.com"];  //邮箱
//    URL = [NSURL URLWithString:@"maps://"];                 //地图
//    URL = [NSURL URLWithString:@"facetime://1234567"];      //facetime
    
    //跳转到系统设置
//    NSURL *URL2;
//    if (IOS_10) {
//        URL2 = [NSURL URLWithString:UIApplicationOpenSettingsURLString];    //适用于iOS >= 8
//    } else {
//        URL2 = [NSURL URLWithString:@"Prefs:root=General"]; //适用于iOS < 10
//    }
    
    //跳转第三方APP
    NSURL *URL3 = [NSURL URLWithString:@"newlife://123456"];
    
    //开始跳转
    if ([[UIApplication sharedApplication] canOpenURL:URL3]) {
        [self openURL:URL3];
    } else {
        [self showAlertControllerWithTitle:@"没有安装" message:nil];
    }
}


- (void)openURL:(NSURL *)URL {
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:URL];
    }
}

@end
