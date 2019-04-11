//
//  PaoMaViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/11.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "PaoMaViewController.h"

@interface PaoMaViewController ()
{
    UILabel *_label;
    CGFloat _width;
}
@end

@implementation PaoMaViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开始跑
    [self beginAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跑马灯";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    //当程序进入到后台时，动画会被中断结束，因此在程序回到前台时需要重新开启动画
    //还有一种情况，当离开此页面时（push到下一页面、切换TabBar）也会中断结束动画，所以应该在 - (void)viewWillAppear 中开启动画。
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 50)];
    backView.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:backView];
    
    NSString *string = @"我是跑马灯呀，啦啦啦啦啦，跑呀跑呀，一遍又一遍呀！";
    //创建label
    _label = [Tools createLabelWithFrame:CGRectZero text:string textColor:WHITECOLOR textAlignment:0];
    _label.font = [UIFont systemFontOfSize:16];
    [backView addSubview:_label];
    
    //计算文字的宽度
    _width = [Tools getMyWidthWithString:string size:CGSizeMake(CGFLOAT_MAX, 50) rFont:16];
}


//开始跑
- (void)beginAnimation
{
    _label.frame = CGRectMake(SCREEN_WIDTH, 0, _width, 50);
    NSTimeInterval duration = _width / 30;  //时间 = 宽度 / 速度  （自行设置）
    
    //这里的 UIViewAnimationOptionCurveLinear 代表匀速运动， UIViewAnimationOptionRepeat 代表循环
    [UIView animateWithDuration:duration delay:0.5 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat animations:^{
        _label.frame = CGRectMake(-_width, 0, _width, 50);
    } completion:^(BOOL finished) {
        NSLog(@"动画结束 = %d", finished);
    }];
}




#pragma mark - %%%%%%%%%%%%%%%%%%%%%%%%%%%%

//从后台回到前台
- (void)willEnterForeground {
    [self beginAnimation];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

@end
