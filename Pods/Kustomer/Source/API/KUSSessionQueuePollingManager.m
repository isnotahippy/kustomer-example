//
//  KUSSessionQueuePollingManager.m
//  Kustomer
//
//  Created by Hunain Shahid on 07/11/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSSessionQueuePollingManager.h"
#import "KUSSessionQueueDataSource.h"
#import "KUSChatMessagesDataSource.h"

#import "KUSUserSession.h"

const NSTimeInterval kOneMinute = 60.0;

@interface KUSSessionQueuePollingManager () <KUSObjectDataSourceListener> {
    __weak KUSUserSession *_userSession;
    NSHashTable<id<KUSSessionQueuePollingListener>> *_listeners;
    
    NSString *_sessionId;
    KUSSessionQueueDataSource *_sessionQueueDataSource;
}

@property (nonatomic, assign, readwrite) BOOL isPollingStarted;
@property (nonatomic, assign, readwrite) BOOL isPollingCanceled;

@end

@implementation KUSSessionQueuePollingManager

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession sessionId:(NSString *)sessionId
{
    self = [super init];
    if (self) {
        _userSession = userSession;
        _sessionId = sessionId;
        _isPollingStarted = NO;
        _isPollingCanceled = NO;
        
        _sessionQueueDataSource = [[KUSSessionQueueDataSource alloc] initWithUserSession:userSession sessionId:sessionId];
        [_sessionQueueDataSource addListener:self];
        
        _listeners = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}

#pragma mark - Internal methods

- (void)_fetchQueueAfterInterval:(NSTimeInterval)interval
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!_isPollingStarted) {
            _isPollingStarted = YES;
            [self notifyAnnouncersDidStartPolling];
        }
        
        [_sessionQueueDataSource fetch];
    });
}

- (NSTimeInterval)_getPollingIntervalFromEstimatedWaitTime:(NSTimeInterval)estimatedWaitTimeSeconds
{
    NSTimeInterval delay = 0;
    if (estimatedWaitTimeSeconds < kOneMinute) {
        delay = 0.1 * kOneMinute;
    } else if (estimatedWaitTimeSeconds < 5 * kOneMinute) {
        delay = 0.5 * kOneMinute;
    } else if (estimatedWaitTimeSeconds < 10 * kOneMinute) {
        delay = kOneMinute;
    } else {
        delay = 0.1 * estimatedWaitTimeSeconds;
    }
    
    return delay;
}

#pragma mark - Public methods

- (void)addListener:(id<KUSSessionQueuePollingListener>)listener
{
    [_listeners addObject:listener];
}

- (void)removeListener:(id<KUSSessionQueuePollingListener>)listener
{
    [_listeners removeObject:listener];
}

- (void)startPolling
{
    // Starting Polling After 2 second to avoid race condition
    [self _fetchQueueAfterInterval:2];
}

- (void)cancelPolling
{
    if (_isPollingStarted) {
        _isPollingCanceled = YES;
        [self notifyAnnouncersDidCancelPolling];
    }
}

- (KUSSessionQueue *)sessionQueue
{
    return _sessionQueueDataSource.object;
}

#pragma mark - Internal listener methods

- (void)notifyAnnouncersDidStartPolling
{
    for (id<KUSSessionQueuePollingListener> listener in [_listeners copy]) {
        if ([listener respondsToSelector:@selector(sessionQueuePollingManagerDidStartPolling:)]) {
            [listener sessionQueuePollingManagerDidStartPolling:self];
        }
    }
}

- (void)notifyAnnouncersDidEndPolling
{
    for (id<KUSSessionQueuePollingListener> listener in [_listeners copy]) {
        if ([listener respondsToSelector:@selector(sessionQueuePollingManagerDidEndPolling:)]) {
            [listener sessionQueuePollingManagerDidEndPolling:self];
        }
    }
}

- (void)notifyAnnouncersDidUpdatePolling:(KUSSessionQueue *)sessionQueue
{
    for (id<KUSSessionQueuePollingListener> listener in [_listeners copy]) {
        if ([listener respondsToSelector:@selector(sessionQueuePollingManager:didUpdateSessionQueue:)]) {
            [listener sessionQueuePollingManager:self didUpdateSessionQueue:sessionQueue];
        }
    }
}

- (void)notifyAnnouncersDidCancelPolling
{
    for (id<KUSSessionQueuePollingListener> listener in [_listeners copy]) {
        if ([listener respondsToSelector:@selector(sessionQueuePollingManagerDidCancelPolling:)]) {
            [listener sessionQueuePollingManagerDidCancelPolling:self];
        }
    }
}

- (void)notifyAnnoucersDidReceiveError:(NSError *)error
{
    for (id<KUSSessionQueuePollingListener> listener in [_listeners copy]) {
        if ([listener respondsToSelector:@selector(sessionQueuePollingManager:didReceiveError:)]) {
            [listener sessionQueuePollingManager:self didReceiveError:error];
        }
    }
}

#pragma mark - KUSObjectDataSourceListener methods

- (void)objectDataSourceDidLoad:(KUSObjectDataSource *)dataSource
{
    if (_isPollingCanceled) {
        return;
    }
    
    KUSSessionQueue *sessionQueue = dataSource.object;
    
    // Notify all announcers for the updated session queue object
    [self notifyAnnouncersDidUpdatePolling:sessionQueue];
    
    // Fetch queue object after specific delay if necessary
    if (sessionQueue.estimatedWaitTimeSeconds == 0) {
        [self notifyAnnouncersDidEndPolling];
        return;
    }
    
    NSTimeInterval interval = [self _getPollingIntervalFromEstimatedWaitTime:sessionQueue.estimatedWaitTimeSeconds];
    [self _fetchQueueAfterInterval:interval];
}

- (void)objectDataSource:(KUSObjectDataSource *)dataSource didReceiveError:(NSError *)error
{
    [self notifyAnnoucersDidReceiveError:error];
}

@end
