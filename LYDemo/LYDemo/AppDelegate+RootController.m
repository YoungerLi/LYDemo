//
//  AppDelegate+RootController.m
//  LYApp
//
//  Created by liyang on 17/6/30.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "AppDelegate+RootController.h"

@implementation AppDelegate (RootController)

- (void)createRootViewControllers
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.tabBarSelectedIndex = 0;
    
    BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
    tabBar.delegate = self;
    self.window.rootViewController = tabBar;
    
    [self.window makeKeyAndVisible];
}




#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 二次点击TabBar刷新页面
    if (tabBarController.selectedIndex == self.tabBarSelectedIndex) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tabBarClick" object:nil];
    }
    self.tabBarSelectedIndex = tabBarController.selectedIndex;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewController.tabBarItem.title isEqualToString:@"钢铁侠"]) {
        
    }
    return YES;
}

@end
