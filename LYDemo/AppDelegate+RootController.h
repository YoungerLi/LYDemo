//
//  AppDelegate+RootController.h
//  LYApp
//
//  Created by liyang on 17/6/30.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (RootController)<UITabBarControllerDelegate>

/// 设置根视图控制器
- (void)createRootViewControllers;

@end
