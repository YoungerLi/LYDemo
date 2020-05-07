//
//  BaseViewController.m
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"进入 %@", [self class]);
    [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:animated];
    if (!self.navigationBarHidden) {
        self.navBarHairlineImageView.hidden = YES;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"]
                                                      forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                                          NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self setUpLeftItemWithImageName:@"arrow_left_white"];
    }
}

#pragma mark - 自定义返回按钮

- (void)setUpLeftItemWithImageName:(NSString *)imageName {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 44);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 导航栏底线

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


#pragma mark -

- (void)dealloc {
    NSLog(@"%@ 释放", [self class]);
}

@end
