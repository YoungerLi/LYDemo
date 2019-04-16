//
//  NSString+Valid.m
//  test
//
//  Created by liyang on 16/8/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)

- (CGFloat)heightWithSize:(CGSize)size font:(UIFont *)font {
    CGRect frame = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return frame.size.height;
}

- (CGFloat)widthWithSize:(CGSize)size font:(UIFont *)font {
    CGRect frame = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return frame.size.width;
}


#pragma mark - 判断

- (BOOL)isChinesePurely {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isNumberPurely {
    NSString *match = @"[0-9]";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidPhoneNum {
    NSString *match = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidEmail {
    NSString *match = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidCardID {
    NSString *match = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidLicenceNumber {
    NSString *match = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEmpty {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
}

- (BOOL)isPositiveNumber {
    NSString *match = @"^\\d+(\\.\\d+)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [predicate evaluateWithObject:self];
}

+ (BOOL)isStringAndLength:(id)obj {
    return [obj isKindOfClass:[NSString class]] && ![obj isEqualToString:@""] && obj != nil;
}

+ (NSString *)isValidStringWithObject:(id)obj defaultString:(NSString *)defaultString {
    if ([NSString isStringAndLength:obj]) {
        return [obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //只去掉首尾的空格和换行
    } else {
        return defaultString;
    }
}

@end
