//
//  UIViewController+HUD.h
//  HYSZBusiness
//
//  Created by 李杨 on 2019/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HUD)

/**
 加载中（无提示文字）不会自动消失
 */
- (void)showLoading;

/**
 加载中（有提示文字）不会自动消失
 */
- (void)showLoadingWith:(NSString *)text;

/**
 提示，1.5秒后自动消失
 */
- (void)showTipWith:(nullable NSString *)text;

/**
 隐藏HUD
 */
- (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
