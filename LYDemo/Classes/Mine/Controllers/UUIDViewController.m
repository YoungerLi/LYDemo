//
//  UUIDViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/12.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "UUIDViewController.h"
#import "UUIDKeychainManager.h"

NSString * const KEY_UUID = @"com.kosien.demo.liyang";

@interface UUIDViewController ()

@end

@implementation UUIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UUID";
    
    NSLog(@"UUID == %@", [UUIDKeychainManager getUUIDInKeychain:KEY_UUID]);
}






@end
