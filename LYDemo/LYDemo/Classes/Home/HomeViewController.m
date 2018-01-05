//
//  HomeViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/3.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Captain America";
    
    
    NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    NSMutableArray *array2 = [array1 mutableCopy];
    
    [array2 removeLastObject];
    
    NSLog(@"array1 == %@", array1);
    NSLog(@"array2 == %@", array2);
    
}



@end
