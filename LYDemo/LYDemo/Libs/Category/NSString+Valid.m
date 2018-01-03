//
//  NSString+Valid.m
//  test
//
//  Created by liyang on 16/8/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)


#pragma mark - ***********判断************
#pragma mark --判断是否是纯汉字
- (BOOL)isChinesePurely
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma mark --判断是否是纯数字
- (BOOL)isNumberPurely
{
    NSString *match = @"[0-9]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma mark --判断是否是合法的手机号
- (BOOL)isValidPhoneNum
{
    NSString *match = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma mark --判断是否是合法的邮箱
- (BOOL)isValidEmail
{
    NSString *match = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma mark --判断是否是合法的身份证号
- (BOOL)isValidCardID
{
    NSString *match = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma mark --判断是否是合法的车牌号
- (BOOL)isValidLicenceNumber
{
    NSString *match = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma mark --判断是否是空字符串
- (BOOL)isEmpty {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}

#pragma mark --判断是否是正数
- (BOOL)isPositiveNumber
{
    NSString *match = @"^\\d+(\\.\\d+)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

#pragma mark --判断是否是有效字符串
+ (BOOL)isStringAndLength:(id)obj
{
    if ([obj isKindOfClass:[NSString class]] && ![obj isEqualToString:@""] && obj != nil) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark --判断obj是不是有效字串，YES返回obj，NO返回defaultString
+ (NSString *)isValidStringWithObject:(id)obj defaultString:(NSString *)defaultString
{
    if ([NSString isStringAndLength:obj]) {
        return [obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //只去掉首尾的空格和换行
    } else {
        return defaultString;
    }
}




@end
