//
//  LYAPIBaseManager.m
//  LYDemo
//
//  Created by wukongzuche on 2019/4/11.
//  Copyright © 2019 kosien. All rights reserved.
//

#import "LYAPIBaseManager.h"

@interface LYAPIBaseManager ()

@property (nonatomic, strong) NSDictionary *rawData;

@end

@implementation LYAPIBaseManager

- (void)loadData {
    NSDictionary *params = [self.paramsSource paramsForApi:self];
    [self requestDataWithParams:params];
}

- (void)requestDataWithParams:(NSDictionary *)params {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:params];
    [mDic setObject:@"beijing" forKey:@"city"];
    self.rawData = [mDic copy];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
        [self.delegate managerCallAPIDidSuccess:self];
    }
}

- (id)fetchDataWithReformer:(id<LYAPIManagerCallbackDataReformer>)reformer {
    id resultData = nil;
    if (reformer && [reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.rawData];
    } else if (self.rawData) {
        resultData = [self.rawData mutableCopy];
    }
    return resultData;
}

@end
