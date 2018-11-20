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
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //创建右滑返回手势
    [self createPanGesture];
}




#pragma mark - 创建右滑返回手势

- (void)createPanGesture
{
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    pan.delegate = self;
    _pan = pan;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)addPanGesture {
    [self.view addGestureRecognizer:_pan];
}




#pragma mark - %%%%%%%%%%%%%%%%%%%%

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
