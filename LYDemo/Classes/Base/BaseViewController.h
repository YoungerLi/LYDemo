//
//  BaseViewController.h
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/// 是否隐藏导航栏
@property (nonatomic, assign) BOOL navigationBarHidden;

/// show Alert
- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message;

@end
