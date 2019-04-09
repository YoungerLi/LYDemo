//
//  CountDownViewController.m
//  LYDemo
//
//  Created by liyang on 2018/5/5.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "CountDownViewController.h"
#import "LYCountDownLabel.h"

@interface CountDownViewController ()<LYCountDownLabelDelegate>
{
    
}
@property (nonatomic, strong) LYCountDownLabel *countDownLabel;
@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"倒计时动画";
    
    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    testButton.backgroundColor = [UIColor redColor];
    [testButton setTitle:@"开始倒计时" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(testButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}


- (void)testButtonClick
{
    [self.view addSubview:self.countDownLabel];
    [self.countDownLabel startCountDown];
}

//倒计时结束
- (void)lyCountDownEnd
{
    NSLog(@"倒计时结束啦，哈哈");
}



- (LYCountDownLabel *)countDownLabel
{
    if (!_countDownLabel) {
        _countDownLabel = [[LYCountDownLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _countDownLabel.center = self.view.center;
        _countDownLabel.delegate = self;
    }
    return _countDownLabel;
}

@end
