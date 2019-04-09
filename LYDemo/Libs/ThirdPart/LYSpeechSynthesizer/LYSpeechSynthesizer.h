//
//  LYSpeechSynthesizer.h
//  text
//
//  Created by liyang on 15/7/17.
//  Copyright © 2015年 liyang. All rights reserved.
//
/**
 *  这是一个文字转语音即合成语音的类，可以将文字以语音的形式表达出来
 *  iOS7及以上版本可以使用 AVSpeechSynthesizer 合成语音
 *  或者采用"科大讯飞"等第三方的语音合成服务
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface LYSpeechSynthesizer : NSObject

+ (instancetype)sharedSpeechSynthesizer;

- (void)speakString:(NSString *)string;

- (void)stopSpeak;

@end
