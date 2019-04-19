//
//  ReactiveObjcViewController.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "ReactiveObjcViewController.h"
#import "RACView.h"

@interface ReactiveObjcViewController ()

@end

@implementation ReactiveObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"ReactiveObjc";
    
    [self demo1];
    [self demo2];
    [self demo3];
}

- (void)demo1 {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    //代替监听事件方法(按钮点击)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了button，哈哈");
        CGRect frame = x.frame;
        frame.size.width += 2;
        x.frame = frame;
    }];
    //代替KVO
    [[button rac_valuesAndChangesForKeyPath:@"frame" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"KVO == %@", x.second);
    }];
}

// 传值
- (void)demo2 {
    RACView *racView = [[RACView alloc] initWithFrame:CGRectMake(50, 170, 200, 50)];
    [self.view addSubview:racView];
    [racView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [[racView rac_signalForSelector:@selector(sendValue:andDic:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"RACView == %@, %@", x.first, x.second);
    }];
}

- (void)demo3 {
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"发送信号1"];
        return nil;
    }];
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"发送信号2"];
        return nil;
    }];
    [self rac_liftSelector:@selector(updateUIWithSignal:signal:) withSignalsFromArray:@[signal1, signal2]];
}

// 更新UI
- (void)updateUIWithSignal:(id)signal1 signal:(id)signal2 {
    NSLog(@"更新UI == %@, %@", signal1, signal2);
}


@end
