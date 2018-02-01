//
//  LYHealthManager.h
//  LYDemo
//
//  Created by liyang on 2018/1/25.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LYHealthAuthorizationBlock)(BOOL success, NSError *error);    //获取权限block
typedef void(^LYHealthResultBlock)(NSInteger steps, NSError *error);        //获取步数block

@interface LYHealthManager : NSObject

/** 单例 */
+ (instancetype)defaultManager;

/** 读取步数 */
- (void)getStepCount:(LYHealthResultBlock)result;

@end
