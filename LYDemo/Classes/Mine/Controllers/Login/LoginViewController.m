//
//  LoginViewController.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/28.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "LoginViewController.h"
#import "LYUser.h"
#import "LYApp.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    
    UIButton *loginButton = [UIButton buttonWithFrame:CGRectMake(0, 50, kSCREEN_WIDTH, 50) backgroundColor:[UIColor redColor] title:@"登录" addTarget:self action:@selector(loginClick)];
    [self.view addSubview:loginButton];
    
    UIButton *logoutButton = [UIButton buttonWithFrame:CGRectMake(0, 150, kSCREEN_WIDTH, 50) backgroundColor:[UIColor redColor] title:@"退出" addTarget:self action:@selector(logoutClick)];
    [self.view addSubview:logoutButton];
    
    UIButton *lookButton = [UIButton buttonWithFrame:CGRectMake(0, 250, kSCREEN_WIDTH, 50) backgroundColor:[UIColor redColor] title:@"查看" addTarget:self action:@selector(lookClick)];
    [self.view addSubview:lookButton];
    
    UIButton *changeButton = [UIButton buttonWithFrame:CGRectMake(0, 350, kSCREEN_WIDTH, 50) backgroundColor:[UIColor redColor] title:@"修改" addTarget:self action:@selector(changeClick)];
    [self.view addSubview:changeButton];
}

// 登录
- (void)loginClick {
    NSDictionary *dic = @{@"mingzi":@"李杨", @"age":@"27", @"address":@"河北邢台"};
    LYUser *user = [LYUser modelWithDictionary:dic];
    [[LYApp sharedInstance] loginWithUser:user];
}

// 退出
- (void)logoutClick {
    [[LYApp sharedInstance] logout];
}

// 查看
- (void)lookClick {
    NSLog(@"name = %@, age = %@", [LYApp sharedInstance].user.name, [LYApp sharedInstance].user.age);
}

// 修改
- (void)changeClick {
    [[LYApp sharedInstance] updateAge:@"30"];
}

@end
