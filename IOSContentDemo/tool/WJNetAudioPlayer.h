//
//  WJNetAudioPlayer.h
//  MusicStreamer
//
//  Created by 幻想无极（谭启宏） on 16/8/31.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**网络音频播放器*/
@interface WJNetAudioPlayer : NSObject

+ (instancetype)sharedManager;

@property (nonatomic,copy,readonly) NSString *currentUrlString; //当前正在播放的url
@property (nonatomic,assign,readonly) BOOL isPlaying;           //正在播放

@property (nonatomic,copy) void (^progressBlock)(CGFloat f,NSString *loadTime,NSString *totalTime);

//开始播放网络音乐
- (void)playWithUrlString:(NSString *)urlString;

- (void)pause;

- (void)stop;


- (BOOL)isPlayAudioWithUrlString:(NSString *)urlString;

@end
