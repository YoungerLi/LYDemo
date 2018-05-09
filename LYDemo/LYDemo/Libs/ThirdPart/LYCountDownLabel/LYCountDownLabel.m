//
//  LYCountDownLabel.m
//  LiteAV
//
//  Created by liyang on 2018/5/5.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "LYCountDownLabel.h"

@interface LYCountDownLabel ()
{
    NSTimer *_timer;
}
@end

@implementation LYCountDownLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:100];
        self.textColor = [UIColor redColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}




- (void)startCountDown
{
    if (self.count == 0) {
        self.count = 3;
    }
    NSLog(@"开始倒计时");
    _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantPast] interval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}


- (void)timerEvent
{
    if (self.count > 0) {
        self.text = [NSString stringWithFormat:@"%d", self.count];
        CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        //字体变化大小
        NSValue *value1 = [NSNumber numberWithFloat:3.0f];
        NSValue *value2 = [NSNumber numberWithFloat:2.0f];
        NSValue *value3 = [NSNumber numberWithFloat:0.7f];
        NSValue *value4 = [NSNumber numberWithFloat:1.0f];
        anima.values = @[value1,value2,value3,value4];
        anima.duration = 0.5;
        [self.layer addAnimation:anima forKey:@"scalsTime"];
        self.count -= 1;
    } else {
        [_timer invalidate];
        _timer = nil;
        if ([self.delegate respondsToSelector:@selector(lyCountDownEnd)]) {
            [self.delegate lyCountDownEnd];
        }
        [self removeFromSuperview];
    }
}


@end
