//
//  MBProgressHUD+Additions.h
//  HYSZBusiness
//
//  Created by 李杨 on 2019/10/9.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Additions)

/// 加载中
+ (void)showLoading;

/// 加载中
+ (void)showLoadingWith:(NSString *)text;

/// 提示，1.5秒后自动消失
+ (void)showTipWith:(nullable NSString *)text;

/// 隐藏HUD
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
