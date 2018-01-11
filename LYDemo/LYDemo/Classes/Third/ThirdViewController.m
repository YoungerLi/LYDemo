//
//  ThirdViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/3.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Thor";
    
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"UUID == %@", UUID);
    
}



@end
