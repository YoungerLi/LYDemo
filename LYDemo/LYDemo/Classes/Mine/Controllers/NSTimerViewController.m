//
//  NSTimerViewController.m
//  text
//
//  Created by liyang on 17/8/14.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "NSTimerViewController.h"

@interface NSTimerViewController ()
{
    NSTimer *_timer;
}
@end

@implementation NSTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"定时器";
    
    
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    testButton.backgroundColor = [UIColor redColor];
    [testButton setTitle:@"开启定时器" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(testButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    
    
    
}


- (void)testButtonClick
{
    NSLog(@"开启定时器");
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    
}


- (void)timerEvent
{
    NSLog(@"定时器");
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [_timer invalidate];
    [super viewWillDisappear:animated];
}

@end
