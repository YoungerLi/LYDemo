//
//  UIViewController+HUD.m
//  HYSZBusiness
//
//  Created by 李杨 on 2019/9/16.
//

#import "UIViewController+HUD.h"

@implementation UIViewController (HUD)

- (void)showLoading {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)showLoadingWith:(NSString *)text {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = text;
}

- (void)showTipWith:(NSString *)text {
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.numberOfLines = 0;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:1.5];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
