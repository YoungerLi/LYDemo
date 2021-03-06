//
//  LYApp.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/26.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "LYApp.h"
#import "LYUser.h"

// 相当于宏定义，更加高效（只能在该类使用）
static NSString *const kUserDataKey = @"LYUserLoginInfo";

@interface LYApp ()

@property (nonatomic, strong) LYUser *user;

@end

@implementation LYApp

+ (instancetype)sharedInstance {
    static LYApp *app;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        app = [[LYApp alloc] initPrivatly];
    });
    return app;
}

- (instancetype)initPrivatly
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDataKey];
        if (dic) {
            self.user = [LYUser modelWithDictionary:dic];
        }
    }
    return self;
}

- (void)loginWithUser:(LYUser *)user {
    self.user = user;
    NSDictionary *dic = [user modelToJSONObject];
    if (dic) {
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kUserDataKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)logout {
    self.user = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDataKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLogin {
    if (self.user) {
        return YES;
    } else {
        return NO;
    }
}

- (void)updateAge:(NSString *)age {
    if (age.length > 0) {
        self.user.age = age;
        NSDictionary *dic = [self.user modelToJSONObject];
        if (dic) {
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kUserDataKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

@end
