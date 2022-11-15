//
//  DDVoiceManager.m
//  测试demo
//
//  Created by majianjie on 2022/6/29.
//  Copyright © 2022 majianjie. All rights reserved.
//

#import "DDVoiceManager.h"
#import <AVFoundation/AVFoundation.h>

@interface DDVoiceManager ()<AVSpeechSynthesizerDelegate>

@property(nonatomic,strong)AVSpeechSynthesizer *speech;
@property(nonatomic,strong)AVSpeechUtterance *utterance;
@property(nonatomic,strong)AVSpeechSynthesisVoice *voice;
@property(nonatomic,copy)NSString *languageType; // 播报语音类型


@end

@implementation DDVoiceManager

+(DDVoiceManager *)shareInstance
{
    static DDVoiceManager *voiceManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        voiceManager = [[super allocWithZone:NULL] init];
    });
    return voiceManager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [DDVoiceManager shareInstance];
}

-(instancetype)copyWithZone:(struct _NSZone *)zone
{
    return [DDVoiceManager shareInstance];
}

-(instancetype)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [DDVoiceManager shareInstance];
}

-(instancetype)init
{
    if ([super init]) {
        NSArray *languages = @[@"en-US",@"zh-CN",@"en-GB",@"zh-HK"];
        _languageType = languages[3];
        _speech = [[AVSpeechSynthesizer alloc] init];
        _speech.delegate = self;
        _utterance = [[AVSpeechUtterance alloc] init];
         _voice = [AVSpeechSynthesisVoice voiceWithLanguage:_languageType];
    }
    return self;
}

// 开始播放
-(void)startWithText:(NSString *)language
{
    
    if ([_speech isPaused]) {
        [_speech continueSpeaking];
    } else {
        _utterance = [_utterance initWithString:language];
        _utterance.rate = 0.5; // 设置语速 0最慢 1最快
        _utterance.voice = _voice;
        [_speech speakUtterance:_utterance];
    }
}

#pragma mark - AVSpeechSynthesizerDelegate
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"---开始播放");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"--完成播放");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"--暂停播放");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"--恢复播放");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"取消播放");
}

@end


