//
//  LYKeychain.h
//  LYDemo
//
//  Created by liyang on 2018/1/13.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 该类用于保存数据到Keychain中
 */
@interface LYKeychain : NSObject

/** 保存数据 */
+ (void)save:(NSString *)service data:(id)data;

/** 读取数据 */
+ (id)load:(NSString *)service;

/** 删除数据 */
+ (void)delete:(NSString *)service;

@end
