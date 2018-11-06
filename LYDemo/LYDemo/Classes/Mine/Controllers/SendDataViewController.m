//
//  SendDataViewController.m
//  text
//
//  Created by Kosien on 17/4/15.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "SendDataViewController.h"

@interface SendDataViewController ()

@property (nonatomic, copy) nameBlock dataBlock1;

@end

@implementation SendDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接收数据";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"发送1" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"发送2" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}


- (void)click
{
    self.dataBlock1 = self.dataBlock;
}

- (void)click2
{
    self.dataBlock1(@"123abcd");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
