//
//  AppDelegate.h
//  LYDemo
//
//  Created by liyang on 2018/1/2.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) NSUInteger tabBarSelectedIndex;   //记录当前的TabBar索引，再次点击刷新

@end
