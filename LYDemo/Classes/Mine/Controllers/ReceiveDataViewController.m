//
//  ReceiveDataViewController.m
//  text
//
//  Created by Kosien on 17/4/15.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "ReceiveDataViewController.h"
#import "SendDataViewController.h"

typedef void(^LYBlock)(NSString *string);

@interface ReceiveDataViewController ()

@end

@implementation ReceiveDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接收数据";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"获取" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    /*
     block:
     
     第一部分：类型： void      无返回值，NSString:有返回值（可以是其他类型）
     第二部分：名字： (^block)  代表block名，随便起
     第三部分：参数： ()        无参数，(int, int):有两个参数（可以是其他类型）
     第四部分：初始化：=后边     相当于给block初始化，赋值
     第五部分：使用： block()   如果有参数就在()写参数，如果无参数就空着。
     
     注意：在使用之前必须先初始化，否则崩溃！！！
     */
    
// 1、无参数无返回值的block
    void (^emptyBlock)(void) = ^(){
        NSLog(@"无参数,无返回值的Block");
    };
    emptyBlock();
    
// 2、有参数无返回值的block
    void (^sumBlock)(int, int) = ^(int a, int b){
        NSLog(@"%d + %d = %d", a, b, a + b);
    };
    sumBlock(2, 3);
    
// 3、有参数有返回值的block
    NSString *(^logBlock)(NSString *, NSString *) = ^(NSString *str1, NSString *str2){
        return [NSString stringWithFormat:@"%@%@",str1,str2];
    };
    NSString *str = logBlock(@"我是", @"block");
    NSLog(@"%@", str);
    
// 4、方法式的block
    [self func:@"123" and:^(NSString *string) {
        NSLog(@"方法式的block = %@", string);
    }];
    //等价于
    [self func:@"456" and:[self blocked]];
}

- (LYBlock)blocked
{
    return ^(NSString *str){
        NSLog(@"block方法%@", str);
    };
}

- (void)func:(NSString *)string and:(LYBlock)block
{
    NSString *str = [NSString stringWithFormat:@"liyang de block = %@", string];
    block(str);
}

- (void)click
{
    SendDataViewController *VC = [[SendDataViewController alloc] init];
    VC.dataBlock = ^(NSString *data) {
        NSLog(@"接收到数据 == %@", data);
    };
    [self.navigationController pushViewController:VC animated:YES];
}



@end
