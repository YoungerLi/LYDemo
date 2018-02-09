//
//  BezierViewController.m
//  text
//
//  Created by Kosien on 17/2/6.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "BezierViewController.h"
#import "UIBezierPathView.h"

@interface BezierViewController ()

@end

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"画图";
    
    
    //画图
    UIBezierPathView *pathView = [[UIBezierPathView alloc] initWithCGPoint:CGPointMake(5, 400)];
    pathView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pathView];
}





@end
