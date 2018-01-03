//
//  BaseViewController.m
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MSLog(@"[Super class]%@", [self class]);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
