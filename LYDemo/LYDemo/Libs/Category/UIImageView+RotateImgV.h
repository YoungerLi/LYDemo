//
//  UIImageView+RotateImgV.h
//  RotateImgV
//
//  Created by Ashen on 15/11/10.
//  Copyright © 2015年 Ashen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RotateImgV)

/** 图片旋转360° */
- (void)rotate360DegreeWithImageView;

/** 停止旋转 */
- (void)stopRotate;

@end
