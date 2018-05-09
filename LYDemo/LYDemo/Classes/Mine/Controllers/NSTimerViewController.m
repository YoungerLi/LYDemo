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
    self.title = @"定时器";
    
    
    UIButton *testButton1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    testButton1.backgroundColor = [UIColor redColor];
    [testButton1 setTitle:@"开启定时器1秒后执行" forState:UIControlStateNormal];
    [testButton1 addTarget:self action:@selector(testButtonClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton1];
    
    UIButton *testButton2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    testButton2.backgroundColor = [UIColor redColor];
    [testButton2 setTitle:@"开启定时器立即执行" forState:UIControlStateNormal];
    [testButton2 addTarget:self action:@selector(testButtonClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton2];
}


- (void)testButtonClick1
{
    NSLog(@"开启定时器1秒后执行");
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    
}

- (void)testButtonClick2
{
    NSLog(@"开启定时器立即执行");
    _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantPast] interval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}



- (void)timerEvent
{
    NSLog(@"定时器");
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [_timer invalidate];
    _timer = nil;
    [super viewWillDisappear:animated];
}

@end
