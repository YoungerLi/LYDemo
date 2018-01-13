//
//  NSDateFormatter+Category.h
//  LYDemo
//
//  Created by liyang on 2017/1/12.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Category)

+ (id)dateFormatter;

+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

/** yyyy-MM-dd HH:mm:ss */
+ (id)defaultDateFormatter;

@end
