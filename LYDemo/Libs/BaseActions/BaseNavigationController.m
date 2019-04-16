//
//  BaseNavigationController.m
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航条的背景颜色
    //方法1
    self.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationBar.translucent = NO; //如果不加这行会导致颜色不纯，加上这行又会导致view的frame下移64，所以还需设置extendedLayoutIncludesOpaqueBars = YES
    //方法2   （此方法也会导致view的frame下移64，所以仍需设置extendedLayoutIncludesOpaqueBars = YES）
    //[self.navigationBar setBackgroundImage:[Tools imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏title的属性
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:WHITECOLOR}];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
