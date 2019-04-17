//
//  RACView.h
//  LYDemo
//
//  Created by wukongzuche on 2019/4/16.
//  Copyright © 2019 kosien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACView : UIView

@property (nonatomic, strong) RACSubject *btnClickSignal;

- (void)sendValue:(NSString *)str andDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
