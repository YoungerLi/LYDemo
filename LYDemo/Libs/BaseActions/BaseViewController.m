//
//  BaseViewController.m
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - 创建右滑返回手势

/**
 实现全屏右滑返回手势：
 1.在当页遵守UIGestureRecognizerDelegate代理，
 2.在viewWillAppear:里调用此方法
 3.在viewWillDisappear:里写self.navigationController.interactivePopGestureRecognizer.enabled = YES;
 */
- (void)addPanGesture {
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    pan.delegate = self;
    _pan = pan;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.view addGestureRecognizer:_pan];
}


#pragma mark - UIAlertController

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
