//
//  AppDelegate+RootController.m
//  LYApp
//
//  Created by liyang on 17/6/30.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "AppDelegate+RootController.h"

@implementation AppDelegate (RootController)

- (void)createRootViewControllers {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
    tabBar.delegate = self;
    self.window.rootViewController = tabBar;
    
    [self.window makeKeyAndVisible];
}


#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == tabBarController.selectedViewController && tabBarController.selectedIndex == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tabBarClick" object:nil];
    }
    return YES;
}

@end
