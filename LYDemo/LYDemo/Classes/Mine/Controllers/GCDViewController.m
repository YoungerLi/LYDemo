//
//  GCDViewController.m
//  text
//
//  Created by Kosien on 17/4/25.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多线程";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
    dispatch_queue_t queue = dispatch_get_main_queue();                                 //主线程
    dispatch_queue_t queue = dispatch_queue_create("chuan1", NULL);                     //串行队列
    dispatch_queue_t queue = dispatch_queue_create("chuan2", DISPATCH_QUEUE_SERIAL);    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("bing", DISPATCH_QUEUE_CONCURRENT);  //并行队列
    */
    
    UIButton *button1 = [Tools createButtonWithFrame:CGRectMake(100, 70, 200, 30) backgroundColor:[UIColor redColor] title:@"同步串行" addTarget:self action:@selector(GCDSyncC)];
    UIButton *button2 = [Tools createButtonWithFrame:CGRectMake(100, 110, 200, 30) backgroundColor:[UIColor redColor] title:@"同步并行" addTarget:self action:@selector(GCDSyncB)];
    UIButton *button3 = [Tools createButtonWithFrame:CGRectMake(100, 150, 200, 30) backgroundColor:[UIColor redColor] title:@"异步串行" addTarget:self action:@selector(GCDAsyncC)];
    UIButton *button4 = [Tools createButtonWithFrame:CGRectMake(100, 190, 200, 30) backgroundColor:[UIColor redColor] title:@"异步并行" addTarget:self action:@selector(GCDAsyncB)];
    UIButton *button5 = [Tools createButtonWithFrame:CGRectMake(100, 230, 200, 30) backgroundColor:[UIColor redColor] title:@"全局并行" addTarget:self action:@selector(GCDGlobal)];
    UIButton *button6 = [Tools createButtonWithFrame:CGRectMake(100, 270, 200, 30) backgroundColor:[UIColor redColor] title:@"dispatch_after" addTarget:self action:@selector(GCDTime)];
    UIButton *button7 = [Tools createButtonWithFrame:CGRectMake(100, 310, 200, 30) backgroundColor:[UIColor redColor] title:@"dispatch_barrier_async" addTarget:self action:@selector(GCDBarrier)];
    UIButton *button8 = [Tools createButtonWithFrame:CGRectMake(100, 350, 200, 30) backgroundColor:[UIColor redColor] title:@"dispatch_group" addTarget:self action:@selector(GCDGroup)];
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    [self.view addSubview:button4];
    [self.view addSubview:button5];
    [self.view addSubview:button6];
    [self.view addSubview:button7];
    [self.view addSubview:button8];
}




#pragma mark - 同步

//同步串行 -- 当前线程，一个一个执行
- (void)GCDSyncC
{
    NSLog(@"开始 - %@", [NSThread currentThread]);
    
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("chuan", DISPATCH_QUEUE_SERIAL);
    
    //任务一
    dispatch_sync(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务1：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务二
    dispatch_sync(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务2：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    NSLog(@"完毕 - %@", [NSThread currentThread]);
}

//同步并行 -- 当前线程，一个一个执行 ==（相当于同步串行）
- (void)GCDSyncB
{
    NSLog(@"开始 - %@", [NSThread currentThread]);
    
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("chuan", DISPATCH_QUEUE_CONCURRENT);
    
    //任务一
    dispatch_sync(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务1：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务二
    dispatch_sync(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务2：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    NSLog(@"完毕 - %@", [NSThread currentThread]);
}




#pragma mark - 异步

//异步串行 -- 另开一个线程，一个一个执行
- (void)GCDAsyncC
{
    NSLog(@"开始 - %@", [NSThread currentThread]);
    
    //创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("chuan", DISPATCH_QUEUE_SERIAL);
    
    //任务一
    dispatch_async(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务1：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务二
    dispatch_async(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务2：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    NSLog(@"完毕 - %@", [NSThread currentThread]);
}

//异步并行 -- 开很多线程，一起执行
- (void)GCDAsyncB
{
    NSLog(@"开始 - %@", [NSThread currentThread]);
    
    //创建一个并行队列
    dispatch_queue_t queue = dispatch_queue_create("bing", DISPATCH_QUEUE_CONCURRENT);
    
    //任务一
    dispatch_async(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务1：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务二
    dispatch_async(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务2：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    NSLog(@"完毕 - %@", [NSThread currentThread]);
    for (int i = 1; i <= 5; i++) {
        NSLog(@"任务3：%d - %@", i, [NSThread currentThread]);
        sleep(1);
    }
}



- (void)GCDGlobal
{
    // 这是一个全局并行队列
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);       //高
    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);    //默认
    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);        //低
    
    NSLog(@"开始 - %@", [NSThread currentThread]);
    //
    dispatch_async(queue3, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务1：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    //
    dispatch_async(queue1, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务2：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    //
    dispatch_async(queue2, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务3：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    NSLog(@"完毕 - %@", [NSThread currentThread]);
}


//任务延迟
- (void)GCDTime
{
    NSLog(@"开始 - %@", [NSThread currentThread]);
    //
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"5s 时间到~~%@", [NSThread currentThread]);
    });
    
    NSLog(@"完毕 - %@", [NSThread currentThread]);
}


//承上启下
- (void)GCDBarrier
{
    //barrier：在barrier方法之前添加的任务会先被执行, 只有等barrier方法之前添加的所有任务全部执行完毕, 才会执行barrier，执行完barrier之后再执行后面的任务。
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"开始 - %@", [NSThread currentThread]);
    
    //任务一
    dispatch_async(queue, ^{
        for (int i = 1; i <= 3; i++) {
            NSLog(@"任务1：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务二
    dispatch_async(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务2：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务“隔断”
    dispatch_barrier_async(queue, ^{
        for (int i = 1; i <= 3; i++) {
            NSLog(@"任务0000：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务三
    dispatch_async(queue, ^{
        for (int i = 1; i <= 3; i++) {
            NSLog(@"任务3：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务四
    dispatch_async(queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务4：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    NSLog(@"完毕 - %@", [NSThread currentThread]);
}


//group
- (void)GCDGroup
{
    //队列组：当这个组里所有的任务都执行完了，队列组会通过一个方法通知我们。
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    NSLog(@"开始 - %@", [NSThread currentThread]);
    
    //任务一
    dispatch_group_async(group, queue, ^{
        for (int i = 1; i <= 3; i++) {
            NSLog(@"任务1：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务二
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (int i = 1; i <= 8; i++) {
            NSLog(@"任务2：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //任务三
    dispatch_group_async(group, queue, ^{
        for (int i = 1; i <= 5; i++) {
            NSLog(@"任务3：%d - %@", i, [NSThread currentThread]);
            sleep(1);
        }
    });
    
    //都执行完毕后会通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"任务执行结束 - %@", [NSThread currentThread]);
    });
    
    NSLog(@"完毕 - %@", [NSThread currentThread]);
}

@end
