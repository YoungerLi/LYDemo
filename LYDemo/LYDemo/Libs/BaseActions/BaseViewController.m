//
//  BaseViewController.m
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}





#pragma mark - %%%%%%%%%%%%%%%%%%%%

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
