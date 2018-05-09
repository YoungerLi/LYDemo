//
//  LYCountDownLabel.h
//  LiteAV
//
//  Created by liyang on 2018/5/5.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYCountDownLabelDelegate <NSObject>
- (void)lyCountDownEnd;
@end

@interface LYCountDownLabel : UILabel

@property (nonatomic, assign) NSInteger count;  //倒计时时间
@property (nonatomic, weak) id<LYCountDownLabelDelegate> delegate;

/**
 开始计时
 */
- (void)startCountDown;

@end
