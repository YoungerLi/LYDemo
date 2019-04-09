//
//  AFNetHelper.h
//  AFNetworking
//
//  Created by ly on 15/12/22.
//  Copyright © 2015年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock) (id data);
typedef void (^FailureBlock) (NSError *error);

static const NSString *KEY = @"hf%82!3~)83?>d";
#define BASEURL @"http://sapi.langfangtong.cn"
#define Version @"v4"

@interface AFNetHelper : NSObject

+ (void)postWithAPI:(NSString *)api andParam:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
