//
//  NSString+Valid.m
//  test
//
//  Created by liyang on 16/8/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)

// 获取字符串的高度
- (CGFloat)heightWithWidth:(CGFloat)width font:(UIFont *)font {
    return [self heightWithSize:CGSizeMake(width, CGFLOAT_MAX) font:font];
}
- (CGFloat)heightWithSize:(CGSize)size font:(UIFont *)font {
    CGRect frame = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return frame.size.height;
}

// 获取字符串的宽度
- (CGFloat)widthWithHeight:(CGFloat)height font:(UIFont *)font {
     return [self widthWithSize:CGSizeMake(CGFLOAT_MAX, height) font:font];
}
- (CGFloat)widthWithSize:(CGSize)size font:(UIFont *)font {
    CGRect frame = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return frame.size.width;
}


// 判断是不是表情符号
- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex:0];
    // Surrogate pair (U+1D000-1F9FF)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

// 判断是否包含表情符号
- (BOOL)isContainsEmoji {
    __block BOOL result = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    return result;
}

// 移除表情符号
- (instancetype)removedEmojiString {
    __block NSMutableString *buffer = [NSMutableString stringWithCapacity:[self length]];
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              [buffer appendString:[substring isEmoji] ? @"": substring];
                          }];
    return buffer;
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
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
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
        return [obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去掉空格和换行
    } else {
        return defaultString;
    }
}

@end
