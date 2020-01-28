//
//  KUSVolumeControlTimerManager.m
//  Kustomer
//
//  Created by BrainX Technologies on 01/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSVolumeControlTimerManager.h"
#import "KUSChatMessagesDataSource.h"

@interface KUSVolumeControlTimerManager ()

@property (atomic) NSMutableDictionary<NSString *, KUSTimer*> *vcTimersHash;
@property (atomic) NSMutableDictionary<NSString *, id<KUSVolumeControlTimerListener>> *listeners;

@end

@implementation KUSVolumeControlTimerManager

#pragma mark - Lifecycle methods

+ (KUSVolumeControlTimerManager *)sharedInstance
{
    static KUSVolumeControlTimerManager *sharedInstance;
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
        _vcTimersHash = [[NSMutableDictionary alloc] init];
        _listeners = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Public methods

- (void)createVolumeControlTimerForSession:(NSString *)sessionId listener:(id<KUSVolumeControlTimerListener>)listener delay:(NSTimeInterval)delay
{
    KUSTimer *_vcTimer = [KUSTimer scheduledTimerWithTimeInterval:delay
                                                         target:self
                                                         selector:@selector(timerComplete:)
                                                         repeats:NO];
    _vcTimer.userInfo = sessionId;
    [_listeners setObject:listener forKey:sessionId];
    [_vcTimersHash setObject:_vcTimer forKey:sessionId];
}

- (void)invalidateVCTimerForSession:(NSString *)sessionId
{
    KUSTimer *timer = [_vcTimersHash objectForKey:sessionId];
    if (timer != nil) {
        [timer invalidate];
    }
    [_vcTimersHash removeObjectForKey:sessionId];
    [_listeners removeObjectForKey:sessionId];
}

- (void)resumeVCTimerForSession:(NSString *)sessionId
{
    KUSTimer *timer = [_vcTimersHash objectForKey:sessionId];
    if (timer != nil) {
        [timer resume];
    }
}

- (void)pauseVCTimers
{
    for(NSString* sessionId in _vcTimersHash) {
        KUSTimer *timer = [_vcTimersHash objectForKey:sessionId];
        [timer pause];
    }
    
}

- (void)resumeVCTimers
{
    NSDictionary *tempTimersHash = [_vcTimersHash copy];
    for(NSString* sessionId in tempTimersHash) {
        KUSTimer *timer = [tempTimersHash objectForKey:sessionId];
        [timer resume];
    }
}

- (void)invalidateVCTimers
{
    for(NSString* sessionId in _vcTimersHash) {
        KUSTimer *timer = [_vcTimersHash objectForKey:sessionId];
        [timer invalidate];
    }
    [_vcTimersHash removeAllObjects];
    [_listeners removeAllObjects];
}

- (BOOL)sessionHasVCTimer:(NSString *)sessionId
{
    return ([_vcTimersHash objectForKey:sessionId] != nil);
}

- (BOOL)hasVCTimers
{
    return [_vcTimersHash count] > 0;
}

- (void)reset
{
    [self invalidateVCTimers];
}

#pragma mark - Timer Completion handler

- (void)timerComplete:(KUSTimer *)timer
{
    NSString *sessionTimerComplete = timer.userInfo;
    id<KUSVolumeControlTimerListener> listener = [_listeners objectForKey:sessionTimerComplete];
    if ([listener respondsToSelector:@selector(volumeControlTimerDidComplete:)]) {
        [listener volumeControlTimerDidComplete:timer];
    }
    [_vcTimersHash removeObjectForKey:sessionTimerComplete];
    [_listeners removeObjectForKey:sessionTimerComplete];
}

@end
