//
//  LYAPIBaseManager.h
//  LYDemo
//
//  Created by wukongzuche on 2019/4/11.
//  Copyright © 2019 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LYAPIBaseManager;

@protocol LYAPIManagerParamsSource <NSObject>
- (NSDictionary *)paramsForApi:(LYAPIBaseManager *)manager;
@end


@protocol LYAPIManagerCallbackDelegate <NSObject>
- (void)managerCallAPIDidSuccess:(LYAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(LYAPIBaseManager *)manager;
@end


@protocol LYAPIManagerCallbackDataReformer <NSObject>
- (id)manager:(LYAPIBaseManager *)manager reformData:(NSDictionary *)data;
@end


@protocol LYAPIBaseManagerProtocol <NSObject>
- (NSString *)apiMethodName;
- (NSString *)serviceIdentifier;
@end


@interface LYAPIBaseManager : NSObject

@property (nonatomic, weak) id<LYAPIManagerParamsSource> paramsSource;
@property (nonatomic, weak) id<LYAPIManagerCallbackDelegate> delegate;

- (void)loadData;
- (id)fetchDataWithReformer:(nullable id<LYAPIManagerCallbackDataReformer>)reformer;

@end

NS_ASSUME_NONNULL_END
