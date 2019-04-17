//
//  RACView.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "RACView.h"

@implementation RACView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
        button1.backgroundColor = [UIColor blueColor];
        [self addSubview:button1];
        [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.btnClickSignal sendNext:@"RACView的按钮点击了"];
        }];
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 40, 50)];
        button2.backgroundColor = [UIColor blueColor];
        [self addSubview:button2];
        [[button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self sendValue:@"1234" andDic:@{@"name":@"liyang", @"age":@"27"}];
        }];
    }
    return self;
}

- (RACSubject *)btnClickSignal {
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}

@end
