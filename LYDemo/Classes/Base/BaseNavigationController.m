//
//  BaseNavigationController.m
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 此行代码防止“自定义返回按钮”或“隐藏导航栏”导致的右滑返回手势失效
    self.interactivePopGestureRecognizer.delegate = (id)self;
    
    /// 设置导航条的背景颜色
    //方法1
    //self.navigationBar.barTintColor = [UIColor orangeColor];
    //如果不加这行会导致颜色不纯，加上这行又会导致view的frame下移64，所以还需设置extendedLayoutIncludesOpaqueBars = YES
    //self.navigationBar.translucent = NO;
    
    //方法2   （此方法也会导致view的frame下移64，所以仍需设置extendedLayoutIncludesOpaqueBars = YES）
    //[self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    
    /// 如有需求则添加，（如添加则注释掉上一行代码，否则崩溃）
    //[self addPanGesture];
}

/// 设置是否允许右滑返回手势
/// 此方法是防止在根视图进行右滑返回手势导致的错误
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark - 其他附加方法

/// 添加全局右滑返回手势
- (void)addPanGesture {
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    [self.view addGestureRecognizer:pan];
}

@end
