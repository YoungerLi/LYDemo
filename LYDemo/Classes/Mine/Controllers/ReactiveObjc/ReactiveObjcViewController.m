//
//  ReactiveObjcViewController.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "ReactiveObjcViewController.h"

@interface ReactiveObjcViewController ()

@end

@implementation ReactiveObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ReactiveObjc";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}



@end
