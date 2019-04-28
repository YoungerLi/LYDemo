//
//  LYUser.h
//  LYDemo
//
//  Created by wukongzuche on 2019/4/26.
//  Copyright © 2019 kosien. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUser : NSObject<YYModel>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *address;

@end

NS_ASSUME_NONNULL_END
