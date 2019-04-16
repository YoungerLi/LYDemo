//
//  NSString+Valid.h
//  test
//
//  Created by liyang on 16/8/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Valid)

/**
 获取字符串的高度
 */
- (CGFloat)heightWithSize:(CGSize)size font:(UIFont *)font;

/**
 获取字符串的宽度
 */
- (CGFloat)widthWithSize:(CGSize)size font:(UIFont *)font;


#pragma mark - 判断

/** 判断是不是纯汉字 */
- (BOOL)isChinesePurely;

/** 判断是不是纯数字 */
- (BOOL)isNumberPurely;

/** 判断是不是合法的手机号 */
- (BOOL)isValidPhoneNum;

/** 判断是不是合法的邮箱 */
- (BOOL)isValidEmail;

/** 判断是不是合法的身份证号 */
- (BOOL)isValidCardID;

/** 判断是不是合法的车牌号 */
- (BOOL)isValidLicenceNumber;

/** 判断是不是空字符串 */
- (BOOL)isEmpty;

/** 判断是不是正数（包括0） */
- (BOOL)isPositiveNumber;

/** 判断是不是有效字符串 */
+ (BOOL)isStringAndLength:(id)obj;

/** 判断obj是不是有效字串，如果是返回obj，如果不是，返回defaultString */
+ (NSString *)isValidStringWithObject:(id)obj defaultString:(NSString *)defaultString;

@end
