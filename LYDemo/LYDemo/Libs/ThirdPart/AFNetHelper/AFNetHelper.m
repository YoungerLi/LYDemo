//
//  AFNetHelper.m
//  AFNetworking
//
//  Created by ly on 15/12/22.
//  Copyright © 2015年 ly. All rights reserved.
//

#import "AFNetHelper.h"

@implementation AFNetHelper

+ (void)postWithAPI:(NSString *)api andParam:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure
{
    api = [NSString stringWithFormat:@"%@/%@",BASEURL, api];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:param];
    NSString *sign = [self createMd5Sign:params];
    [params setObject:sign forKey:@"sign"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:api version:Version parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            id allData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(allData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



+ (NSString *)createMd5Sign:(NSDictionary*)dict
{
    NSString *resultStr;
    if (dict.count >= 1) {
        NSMutableString *contentString = [NSMutableString string];
        NSArray *keys = [dict allKeys];
        
        NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        for (NSString *categoryId in sortedArray) {
            NSString *string = [NSString stringWithFormat:@"%@", dict[categoryId]];
            if (![string isEqualToString:@"sign"] &&
                ![string isEqualToString:@"key"] &&
                ![string isEqualToString:@""] ) {
                [contentString appendFormat:@"%@=%@&", categoryId, string];
            }
        }
        if (contentString.length) {
            resultStr = [NSString stringWithFormat:@"%@",[contentString substringToIndex:contentString.length-1]];
        } else {
            resultStr = @"";
        }
    } else {
        resultStr = @"";
    }
    
    resultStr = [NSString stringWithFormat:@"%@&key=%@",resultStr,KEY];
    resultStr = [Tools getMD5_32Bit_string:resultStr];
    resultStr = [resultStr uppercaseString];
    resultStr = [NSString stringWithFormat:@"%@",resultStr];
    
    return resultStr;
    
}



@end
