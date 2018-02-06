//
//  CopyViewController.m
//  LYDemo
//
//  Created by liyang on 2018/1/16.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "CopyViewController.h"
#import "CopyModel.h"

@interface CopyViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浅复制与深复制";
    _dataArray = [[NSMutableArray alloc] init];
    
    CopyModel *model1 = [[CopyModel alloc] init];
    CopyModel *model2 = [[CopyModel alloc] init];
    model1.name = @"China";
    model1.age = @"20";
    model2.name = @"USA";
    model2.age = @"30";
    [_dataArray addObject:model1];
    [_dataArray addObject:model2];
    MSLog(@"_dataArray == %p, %@", _dataArray, _dataArray);
    
    [self deepCopy1];
//    [self deepCopy2];
}


// 深复制方法一
- (void)deepCopy1
{
    //该方法需要数组里的每个对象遵循NSCopying协议，如果没遵循NSCopying协议会crash
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithArray:_dataArray copyItems:YES];
    for (CopyModel *model in mArray) {
        if ([model.age isEqualToString:@"20"]) {
            model.name = @"liyang";
        }
    }
    MSLog(@"mArray == %p, %@", mArray, mArray);
    MSLog(@"_dataArray == %p, %@", _dataArray, _dataArray);
}

// 深复制方法二
- (void)deepCopy2
{
    //该方法是将数组归档，然后再解档。需要在model对象里遵循NSCoding协议
    NSMutableArray *mArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:_dataArray]];
    for (CopyModel *model in mArray) {
        if ([model.age isEqualToString:@"20"]) {
            model.name = @"liyang";
        }
    }
    MSLog(@"mArray == %p, %@", mArray, mArray);
    MSLog(@"_dataArray == %p, %@", _dataArray, _dataArray);
}

@end
