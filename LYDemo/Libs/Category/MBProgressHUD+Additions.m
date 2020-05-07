//
//  MBProgressHUD+Additions.m
//  HYSZBusiness
//
//  Created by 李杨 on 2019/10/9.
//

#import "MBProgressHUD+Additions.h"

@implementation MBProgressHUD (Additions)

+ (void)showLoading {
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
    [self showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
}

+ (void)showLoadingWith:(NSString *)text {
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
    MBProgressHUD *hud = [self showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.label.text = text;
}

+ (void)showTipWith:(NSString *)text {
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
    if (text.length) {
        MBProgressHUD *hud = [self showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.numberOfLines = 0;
        hud.label.text = text;
        [hud hideAnimated:YES afterDelay:1.5];        
    }
}

+ (void)hideHUD {
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
}

@end
