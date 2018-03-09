//
//  LYSpeechSynthesizer.m
//  text
//
//  Created by liyang on 15/7/17.
//  Copyright © 2015年 liyang. All rights reserved.
//

#import "LYSpeechSynthesizer.h"

@interface LYSpeechSynthesizer ()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong, readwrite) AVSpeechSynthesizer *speechSynthesizer;

@end

@implementation LYSpeechSynthesizer

+ (instancetype)sharedSpeechSynthesizer
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LYSpeechSynthesizer alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self buildSpeechSynthesizer];
    }
    return self;
}

- (void)buildSpeechSynthesizer
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        return;
    }
    
    //简单配置一个AVAudioSession以便可以在后台播放声音，更多细节参考AVFoundation官方文档
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:NULL];
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.speechSynthesizer setDelegate:self];
}

- (void)speakString:(NSString *)string
{
    if (self.speechSynthesizer) {
        AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
        [aUtterance setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
        
        aUtterance.rate = 0.07; //设置语速为0.05
        
        if ([self.speechSynthesizer isSpeaking]) {
            [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        }
        
        [self.speechSynthesizer speakUtterance:aUtterance];
    }
}

- (void)stopSpeak
{
    if (self.speechSynthesizer) {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}

@end
