//
//  HomeViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/3.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Captain America";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarClick) name:@"tabBarClick" object:nil];
    
}

- (void)tabBarClick
{
    if (self.tabBarController.selectedIndex == 0) {
        NSLog(@"刷新 = 美国队长");
    }
}

@end
