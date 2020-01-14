//
//  NSDictionary+Utils.h
//  HYSZBusiness
//
//  Created by 李杨 on 2019/11/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Utils)

/// json字符串转字典
/// @param jsonString json字符串
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
