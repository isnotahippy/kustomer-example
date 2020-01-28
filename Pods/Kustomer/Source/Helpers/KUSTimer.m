//
//  KUSTimer.m
//  Kustomer
//
//  Created by Daniel Amitay on 2/21/18.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSTimer.h"

@interface KUSWeakTarget : NSObject

- (instancetype)initWithTarget:(id)target selector:(SEL)selector timer:(KUSTimer *)timer;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (void)fire;

@end

@interface KUSTimer ()

@property (nonatomic, assign) NSTimeInterval timeInterval;

@end

@implementation KUSTimer {
    KUSWeakTarget *_target;
    NSDate *_timerStarted;
    BOOL _repeats;
}



#pragma mark - Class methods

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeats
{
    return [[self alloc] initWithTimeInterval:interval
                                       target:target
                                     selector:selector
                                      repeats:repeats];
}

#pragma mark - Lifecycle methods

- (instancetype)initWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeats
{
    self = [super init];
    if (self) {
        KUSWeakTarget *weakTarget = [[KUSWeakTarget alloc] initWithTarget:target selector:selector timer:self];
        _target = weakTarget;
        _repeats = repeats;
        _timeInterval = interval;
        [self createTimerAndAddToRunLoop:interval];
    }
    return self;
}

- (void)dealloc
{
    [self invalidate];
    _target = nil;
}

#pragma mark - Internal methods

- (void)fire
{
    [_target fire];
}

- (void)createTimerAndAddToRunLoop:(NSTimeInterval) interval
{
    _timer = [NSTimer timerWithTimeInterval:interval
                                     target:_target
                                   selector:@selector(fire)
                                   userInfo:nil
                                    repeats:_repeats];
    _timer.tolerance = MIN(interval / 20.0, 1.0);
    _timerStarted = [NSDate date];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark - Public methods

- (void)invalidate
{
    [_timer invalidate];
    _timer = nil;
    _timerStarted = nil;
}

- (void)pause
{
    [_timer invalidate];
    _timer = nil;
}

- (void)resume
{
    if (!_timerStarted) {
        return;
    }
    
    NSTimeInterval timeRemaining = _timeInterval - [[NSDate date] timeIntervalSinceDate:_timerStarted];
    BOOL shouldResume = _timer == nil && timeRemaining > 0;
    if (shouldResume) {
        [self createTimerAndAddToRunLoop: timeRemaining];
    } else {
        [self fire];
    }
}

- (NSTimeInterval)timeInterval
{
    return _timeInterval;
}

@end

@implementation KUSWeakTarget {
    __weak id _target;
    SEL _selector;
    __weak KUSTimer *_timer;
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector timer:(KUSTimer *)timer
{
    self = [super init];
    if (self) {
        _target = target;
        _selector = selector;
        _timer = timer;
    }
    return self;
}

- (void)fire
{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [_target performSelector:_selector withObject:_timer];
#pragma clang diagnostic pop
}

@end
