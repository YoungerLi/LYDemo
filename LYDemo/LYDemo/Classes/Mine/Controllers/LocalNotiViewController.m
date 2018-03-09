//
//  LocalNotiViewController.m
//  text
//
//  Created by Kosien on 17/1/17.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "LocalNotiViewController.h"

@interface LocalNotiViewController ()

@end

@implementation LocalNotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"本地通知";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH-20, 50)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"发送一个本地通知" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

#pragma mark - 发送一个本地通知
- (void)click
{
    if (@available(iOS 10.0, *)) {
        //iOS10以上
        //设置内容
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.sound = [UNNotificationSound defaultSound];
        content.title = @"title-ios10";
        content.subtitle = @"subTitle-ios10";
        content.body = @"iOS10的本地通知body哈哈";
        content.userInfo = @{@"info":@"iOS10以上发送的本地通知"};
        content.badge = @1;
        //设置发送时间
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        //设置request
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"ios10.1" content:content trigger:trigger];
        //添加本地推送
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"ios10以上--发送本地通知啦");
        }];
        
    } else {
        //iOS10以下
        NSLog(@"ios10以下--发送本地通知啦");
        UILocalNotification *local = [[UILocalNotification alloc] init];
        local.timeZone = [NSTimeZone defaultTimeZone];                  //时区，一般取默认的
        local.soundName = UILocalNotificationDefaultSoundName;          //通知的声音
        local.applicationIconBadgeNumber = 1;                           //角标
        local.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];       //设置通知发出的时间
        local.alertBody = @"欢迎来到本地通知测试现场";                       //设置通知的内容
        local.userInfo = @{@"info":@"iOS10以下发送的本地通知"};             //设置通知之后的属性
        //local.repeatInterval = NSCalendarUnitMinute;
        [[UIApplication sharedApplication] scheduleLocalNotification:local];
    }
    
    //极光本地推送
//    //设置内容
//    JPushNotificationContent *content = [[JPushNotificationContent alloc] init];
//    content.title = @"极光推送测试";
//    content.subtitle = @"推送测试的副标题哈哈";
//    content.body = @"这是极光推送测试现场嘻嘻";
//    content.badge = @1;
//    //content.sound = @"sound.wav";
//    content.userInfo = @{@"info":@"极光发送的本地通知"};
//    //设置发送时间
//    JPushNotificationTrigger *trigger = [[JPushNotificationTrigger alloc] init];
//    if (IOS_10) {
//        trigger.timeInterval = 5;
//    } else {
//        trigger.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    }
//    //设置request
//    JPushNotificationRequest *request = [[JPushNotificationRequest alloc] init];
//    request.content = content;
//    request.trigger = trigger;
//    request.requestIdentifier = @"jpush";
//    request.completionHandler = ^(id result) {
//        NSLog(@"极光发送本地通知-结果返回 = %@", result);
//    };
//    //添加本地推送
//    [JPUSHService addNotification:request];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
