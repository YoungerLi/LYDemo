//
//  NSDictionary+Utils.m
//  HYSZBusiness
//
//  Created by 李杨 on 2019/11/8.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if (error) {
        NSLog(@"json解析失败：%@", error);
        return nil;
    }
    return dic;
}

@end
