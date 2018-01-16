//
//  CopyModel.h
//  LYDemo
//
//  Created by liyang on 2018/1/16.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CopyModel : NSObject<NSCopying, NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

@end
