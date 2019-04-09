//
//  UUIDKeychainManager.h
//  LYDemo
//
//  Created by liyang on 2018/1/13.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUIDKeychainManager : NSObject

/**
 从Keychain中获取设备唯一标识符
 */
+ (NSString *)getUUIDInKeychain:(NSString *)service;

@end
