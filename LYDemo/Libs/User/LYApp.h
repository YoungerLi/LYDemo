//
//  LYApp.h
//  LYDemo
//
//  Created by wukongzuche on 2019/4/26.
//  Copyright © 2019 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LYUser;

@interface LYApp : NSObject

@property (nonatomic, readonly) LYUser *user;
@property (nonatomic, readonly) BOOL isLogin;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)sharedInstance;

/// 登录
- (void)loginWithUser:(LYUser *)user;

/// 退出
- (void)logout;


/// 更改年龄
- (void)updateAge:(NSString *)age;

@end

NS_ASSUME_NONNULL_END
