//
//  UUIDKeychainManager.m
//  LYDemo
//
//  Created by liyang on 2018/1/13.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "UUIDKeychainManager.h"
#import "LYKeychain.h"

@implementation UUIDKeychainManager

+ (NSString *)getUUIDInKeychain:(NSString *)service
{
    NSString *UUID = [LYKeychain load:service];
    if (UUID == nil || [UUID isEqualToString:@""] || [UUID isKindOfClass:[NSNull class]]) {
        UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [LYKeychain save:service data:UUID];
    }
    return UUID;
}

@end
