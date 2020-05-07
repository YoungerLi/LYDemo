//
//  BaseTabBarController.m
//  AppNew
//
//  Created by liyang on 17/8/6.
//  Copyright © 2017年 Li Yang. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "MineViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViewControllers];
    [self configTabBarItems];
}

- (void)configViewControllers {
    HomeViewController *VC1 = [[HomeViewController alloc] init];
    BaseNavigationController *NC1 = [[BaseNavigationController alloc] initWithRootViewController:VC1];
    
    SecondViewController *VC2 = [[SecondViewController alloc] init];
    BaseNavigationController *NC2 = [[BaseNavigationController alloc] initWithRootViewController:VC2];
    
    ThirdViewController *VC3 = [[ThirdViewController alloc] init];
    BaseNavigationController *NC3 = [[BaseNavigationController alloc] initWithRootViewController:VC3];
    
    MineViewController *VC4 = [[MineViewController alloc] init];
    BaseNavigationController *NC4 = [[BaseNavigationController alloc] initWithRootViewController:VC4];
    
    self.viewControllers = @[NC1, NC2, NC3, NC4];
}


- (void)configTabBarItems {
    //文字属性
    NSArray *titleArray = @[@"美国队长", @"钢铁侠", @"雷神", @"绿巨人"];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
                                NSForegroundColorAttributeName:[UIColor grayColor]};
    NSDictionary *selectAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
                                      NSForegroundColorAttributeName:[UIColor orangeColor]};
    //图片
    NSArray *imageArray = @[@"home", @"msgBoard", @"shop", @"me"];
    NSArray *imageSelectArray = @[@"home_select", @"msgBoard_select", @"shop_select", @"me_select"];
    
    NSInteger index = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        //设置文字
        item.title = titleArray[index];
        [item setTitleTextAttributes:attribute forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectAttribute forState:UIControlStateSelected];
        item.titlePositionAdjustment = UIOffsetMake(0, -3);  //上移3pt
        //设置图片
        item.image = [[UIImage imageNamed:imageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:imageSelectArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        index++;
    }
    
    // 设置文字在iOS 13下的属性
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = attribute;
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectAttribute;
        appearance.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
        appearance.shadowColor = [UIColor clearColor];
        self.tabBar.standardAppearance = appearance;
    } else {
        self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
        self.tabBar.shadowImage = [UIImage new];
    }
    // 设置阴影
    self.tabBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, -3);
    self.tabBar.layer.shadowOpacity = 0.1;
    
    self.tabBar.translucent = NO;
}

@end
