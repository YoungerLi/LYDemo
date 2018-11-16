//
//  UIView+Animation.h
//  LYHeadNews
//
//  Created by liyang on 2018/11/10.
//  Copyright © 2018 kosien. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Animation)

/** 开始旋转 */
- (void)rotationAnimation;

/** 停止旋转 */
- (void)stopRotation;

@end

NS_ASSUME_NONNULL_END
