//
//  BaseViewController.h
//  LYApp
//
//  Created by liyang on 17/7/1.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

/// 导航栏底线 默认隐藏
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

/// 是否隐藏导航栏 默认NO
@property (nonatomic, assign) BOOL navigationBarHidden;

/// 自定义返回按钮
- (void)setUpLeftItemWithImageName:(NSString *)imageName;

/// 点击返回按钮
- (void)backAction;

@end

NS_ASSUME_NONNULL_END
