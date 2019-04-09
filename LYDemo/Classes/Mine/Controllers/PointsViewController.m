//
//  PointsViewController.m
//  LYDemo
//
//  Created by liyang on 2018/8/8.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "PointsViewController.h"

@interface PointsViewController ()
{
    UILabel *_label;
}
@end

@implementation PointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self getPoints];
}

// 创建界面
- (void)createUI
{
    _label = [Tools createLabelWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVBAR_HEIGHT) text:nil textColor:[UIColor redColor] textAlignment:1];
    [self.view addSubview:_label];
}

// 获取积分
- (void)getPoints
{
    [AFNetHelper postWithAPI:@"balance" andParam:@{@"aid":self.aid} success:^(id data) {
        MSLog(@"用户余额等信息 == %@", data);
        if ([data[@"code"] integerValue] == 1) {
            _label.text = [NSString stringWithFormat:@"当前积分为：%@", data[@"integral"]];
        } else {
            _label.text = @"获取信息失败";
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
