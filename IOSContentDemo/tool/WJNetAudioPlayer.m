//
//  WJNetAudioPlayer.m
//  MusicStreamer
//
//  Created by 幻想无极（谭启宏） on 16/8/31.
//  Copyright © 2016年 幻想无极（谭启宏）. All rights reserved.
//

#import "WJNetAudioPlayer.h"
#import "FSAudioController.h"

@interface WJNetAudioPlayer () {
    NSTimer *_progressUpdateTimer;
}

@property (nonatomic,strong) FSAudioController *audioController;//控制


@end

@implementation WJNetAudioPlayer

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FSAudioStreamStateChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FSAudioStreamErrorNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FSAudioStreamMetaDataNotification object:nil];
    [_progressUpdateTimer invalidate];
    _progressUpdateTimer = nil;
}

+ (instancetype)sharedManager {
    static WJNetAudioPlayer *player = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[WJNetAudioPlayer alloc]init];
    });
    return player;
}

- (void)playWithUrlString:(NSString *)urlString {
    if (![urlString isEqualToString:_currentUrlString]) {
        _currentUrlString = urlString;
        self.audioController.url = [NSURL URLWithString:urlString];
        [self play];
    }else {
        [self pause];
    }
    _isPlaying = YES;
}

- (void)play {
    [self.audioController play];
    _isPlaying = YES;
}
//暂停和恢复暂停
- (void)pause {
    [self.audioController pause];
    _isPlaying = NO;
}
- (void)stop {
    [self.audioController stop];
    _isPlaying = NO;
}

- (BOOL)isPlayAudioWithUrlString:(NSString *)urlString; {
    if ([urlString isEqualToString:_currentUrlString]) {
        if (_isPlaying) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (FSAudioController *)audioController
{
    if (!_audioController) {
        _audioController = [[FSAudioController alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(audioStreamStateDidChange:)
                                                     name:FSAudioStreamStateChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(audioStreamErrorOccurred:)
                                                     name:FSAudioStreamErrorNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(audioStreamMetaDataAvailable:)
                                                     name:FSAudioStreamMetaDataNotification
                                                   object:nil];
    }
    return _audioController;
}



- (void)updatePlaybackProgress
{
    if (self.audioController.activeStream.continuous) {
        //        [self.progressTextFieldCell setTitle:@""];
    } else {
        FSStreamPosition cur = self.audioController.activeStream.currentTimePlayed;
        FSStreamPosition end = self.audioController.activeStream.duration;
        CGFloat loadTime = cur.minute *60 + cur.second;
        CGFloat totalTime = end.minute*60 + end.second;
        NSString *loadDate = [NSString stringWithFormat:@"%i:%02i",cur.minute, cur.second];
        NSString *totalDate = [NSString stringWithFormat:@"%i:%02i",end.minute, end.second];
        if (self.progressBlock) {
            self.progressBlock(loadTime/totalTime,loadDate,totalDate);
        }
//        NSLog(@"%@",[NSString stringWithFormat:@"%i:%02i / %i:%02i",
//                     cur.minute, cur.second,
//                     end.minute, end.second]);
    }
}

#pragma mark - 播放控制的通知

- (void)audioStreamStateDidChange:(NSNotification *)notification {
    NSString *statusRetrievingURL = @"Retrieving stream URL";
    NSString *statusBuffering = @"Buffering...";
    NSString *statusSeeking = @"Seeking...";
    NSString *statusEmpty = @"";
    
    NSDictionary *dict = [notification userInfo];
    int state = [[dict valueForKey:FSAudioStreamNotificationKey_State] intValue];
    switch (state) {
        case kFsAudioStreamRetrievingURL:
            if (_progressUpdateTimer) {
                [_progressUpdateTimer invalidate];
            }
            NSLog(@"%@",statusRetrievingURL);
            break;
        case kFsAudioStreamStopped:
            NSLog(@"%@",statusEmpty);
            if (_progressUpdateTimer) {
                [_progressUpdateTimer invalidate];
            }
            break;
        case kFsAudioStreamBuffering:
            NSLog(@"%@",statusBuffering);
            if (_progressUpdateTimer) {
                [_progressUpdateTimer invalidate];
            }
            break;
        case kFsAudioStreamSeeking:
            NSLog(@"%@",statusSeeking);
            break;
        case kFsAudioStreamPlaying:
            if (_progressUpdateTimer) {
                [_progressUpdateTimer invalidate];
            }
            
            _progressUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                    target:self
                                                                  selector:@selector(updatePlaybackProgress)
                                                                  userInfo:nil
                                                                   repeats:YES];
            break;
        case kFsAudioStreamFailed:
            if (_progressUpdateTimer) {
                [_progressUpdateTimer invalidate];
            }
            break;
        default:
            break;
    }
}

- (void)audioStreamErrorOccurred:(NSNotification *)notification {
    NSDictionary *dict = [notification userInfo];
    int errorCode = [[dict valueForKey:FSAudioStreamNotificationKey_Error] intValue];
    
    switch (errorCode) {
        case kFsAudioStreamErrorOpen:
            NSLog(@"Cannot open the audio stream");
            break;
        case kFsAudioStreamErrorStreamParse:
            NSLog(@"Cannot read the audio stream");
            break;
        case kFsAudioStreamErrorNetwork:
            NSLog(@"Network failed: cannot play the audio stream");
            break;
        default:
            NSLog(@"Unknown error occurred");
            break;
    }
}

- (void)audioStreamMetaDataAvailable:(NSNotification *)notification {
    NSDictionary *dict = [notification userInfo];
    NSDictionary *metaData = [dict valueForKey:FSAudioStreamNotificationKey_MetaData];
    NSString *streamTitle = [metaData objectForKey:@"StreamTitle"];
    NSLog(@"%@",streamTitle);
}


@end
