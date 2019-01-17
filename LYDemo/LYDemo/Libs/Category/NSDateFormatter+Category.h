//
//  NSDateFormatter+Category.h
//  LYDemo
//
//  Created by liyang on 2017/1/12.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Category)

/** 自定义时间样式 */
+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)dateFormat;

/** yyyy-MM-dd HH:mm:ss */
+ (NSDateFormatter *)defaultDateFormatter;

/** yyyy-MM-dd */
+ (NSDateFormatter *)dateFormatterOfDate;

/** HH:mm:ss */
+ (NSDateFormatter *)dateFormatterOfTime;

@end
