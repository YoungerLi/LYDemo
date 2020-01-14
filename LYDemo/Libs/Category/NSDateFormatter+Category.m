//
//  NSDateFormatter+Category.m
//  LYDemo
//
//  Created by liyang on 2017/1/12.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (NSDateFormatter *)defaultDateFormatter {
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDateFormatter *)dateFormatterOfDate {
    return [self dateFormatterWithFormat:@"yyyy-MM-dd"];
}

+ (NSDateFormatter *)dateFormatterOfTime {
    return [self dateFormatterWithFormat:@"HH:mm:ss"];
}

@end
