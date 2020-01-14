//
//  AppDelegate.m
//  LYDemo
//
//  Created by liyang on 2018/1/2.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RootController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self createRootViewControllers];
    
    return YES;
}

@end
