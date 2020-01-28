//
//  KUSAudio.m
//  Kustomer
//
//  Created by Daniel Amitay on 8/30/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSAudio.h"

#import <AVFoundation/AVFoundation.h>

@interface KUSAudio () <AVAudioPlayerDelegate> {
    NSMutableSet<AVAudioPlayer *> *_playingAudioPlayers;
}

@end

@implementation KUSAudio

#pragma mark - Public methods

+ (void)playMessageReceivedSound
{
    [[self sharedInstance] _playMessageReceivedSound];
}

#pragma mark - Lifecycle methods

+ (KUSAudio *)sharedInstance
{
    static KUSAudio *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _playingAudioPlayers = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)dealloc
{
    for (AVAudioPlayer *player in _playingAudioPlayers) {
        player.delegate = nil;
        [player stop];
    }
    [_playingAudioPlayers removeAllObjects];
}

#pragma mark - Internal methods

- (void)_playMessageReceivedSound
{
    if (_playingAudioPlayers.count == 0) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient
                                         withOptions:AVAudioSessionCategoryOptionDuckOthers
                                               error:nil];
    }
    NSURL *fileURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"message_received" withExtension:@"m4a"];
    NSError *audioError;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&audioError];
    if (audioPlayer && audioError == nil) {
        [_playingAudioPlayers addObject:audioPlayer];
        audioPlayer.delegate = self;
        [audioPlayer play];
    }
}

#pragma mark - AVAudioPlayerDelegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    player.delegate = nil;
    [player stop];
    [_playingAudioPlayers removeObject:player];
    if (_playingAudioPlayers.count == 0) {
        [[AVAudioSession sharedInstance] setActive:NO
                                         withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation
                                         error:nil];
    }
}

@end
