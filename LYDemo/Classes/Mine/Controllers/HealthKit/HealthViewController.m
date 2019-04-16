//
//  HealthViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/25.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "HealthViewController.h"
#import "LYHealthManager.h"

@interface HealthViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"健康数据";
    
    self.button = [Tools createButtonWithFrame:CGRectMake(100, 100, 200, 100) backgroundColor:[UIColor redColor] title:nil addTarget:self action:@selector(click)];
    [self.view addSubview:self.button];
}

- (void)click
{
    [[LYHealthManager defaultManager] getStepCount:^(NSInteger steps, NSError *error) {
        if (error) {
            NSLog(@"error = %@", error);
        } else {
            [self.button setTitle:[NSString stringWithFormat:@"今日走了%zd步", steps] forState:UIControlStateNormal];
        }
    }];
}

@end
