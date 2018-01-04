//
//  BaseTabBarController.m
//  AppNew
//
//  Created by liyang on 17/8/6.
//  Copyright © 2017年 Li Yang. All rights reserved.
//

#import "BaseTabBarController.h"

@implementation UIImage (originalImage)

+ (UIImage *)originalImageWithImageName:(NSString *)ImageName
{
    UIImage * image = [UIImage imageNamed:ImageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end


@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configViewController];
    [self configTabBar];
    self.tabBar.barTintColor = [UIColor whiteColor];
}

- (void)configViewController
{
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


- (void)configTabBar
{
    //文字属性
    NSArray *titleArray = @[@"美国队长", @"钢铁侠", @"雷神", @"绿巨人"];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:[UIColor grayColor]};
    NSDictionary *selectAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:11], NSForegroundColorAttributeName:[UIColor orangeColor]};
    
    //图片
    NSArray *imageArray = @[@"home", @"msgBoard", @"shop", @"me"];
    NSArray *imageSelectArray = @[@"home_select", @"msgBoard_select", @"shop_select", @"me_select"];
    
    NSInteger index = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        //设置文字
        item.title = titleArray[index];
        [item setTitleTextAttributes:selectAttribute forState:UIControlStateSelected];//选中状态
        [item setTitleTextAttributes:attribute forState:UIControlStateNormal];//一般状态
        item.titlePositionAdjustment = UIOffsetMake(0, -3);  //上移3pt
        //设置图片
        UIImage *image = [UIImage imageNamed:imageArray[index]];
        UIImage *selectImage = [UIImage originalImageWithImageName:imageSelectArray[index]];
        item.image = image;
        item.selectedImage = selectImage;
        
        index++;
    }
    
    //设置TabBar顶部线的颜色
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 0.3);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, LineColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundImage:[Tools imageWithColor:WHITECOLOR]];
}

@end
