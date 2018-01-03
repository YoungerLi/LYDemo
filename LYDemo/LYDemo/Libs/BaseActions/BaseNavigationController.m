//
//  BaseNavigationController.m
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //如果在plist里加了View controller-based status bar appearance = NO，那么用系统的方法设置状态栏颜色。否则系统无效
    //修改状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    //设置导航条的背景颜色
    self.navigationBar.barTintColor = [UIColor orangeColor];
    //设置导航栏title的属性
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:WHITECOLOR}];
    
    
    //设置返回手势的代理
    self.interactivePopGestureRecognizer.delegate = self;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


//设置是否允许返回手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}




@end
