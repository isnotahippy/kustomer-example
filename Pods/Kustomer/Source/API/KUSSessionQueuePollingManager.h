//
//  KUSSessionQueuePollingManager.h
//  Kustomer
//
//  Created by Hunain Shahid on 07/11/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KUSSessionQueue.h"

@class KUSUserSession;
@protocol KUSSessionQueuePollingListener;
@interface KUSSessionQueuePollingManager : NSObject

@property (nonatomic, assign, readonly) BOOL isPollingStarted;
@property (nonatomic, assign, readonly) BOOL isPollingCanceled;

- (instancetype)initWithUserSession:(KUSUserSession *)userSession sessionId:(NSString *)sessionId;
- (instancetype)initWithUserSession:(KUSUserSession *)userSession NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

// Listener methods
- (void)addListener:(id<KUSSessionQueuePollingListener>)listener;
- (void)removeListener:(id<KUSSessionQueuePollingListener>)listener;

- (void)startPolling;
- (void)cancelPolling;
- (KUSSessionQueue *)sessionQueue;

@end

@protocol KUSSessionQueuePollingListener <NSObject>

@optional
- (void)sessionQueuePollingManagerDidStartPolling:(KUSSessionQueuePollingManager *)manager;
- (void)sessionQueuePollingManager:(KUSSessionQueuePollingManager *)manager didUpdateSessionQueue:(KUSSessionQueue *)sessionQueue;
- (void)sessionQueuePollingManagerDidEndPolling:(KUSSessionQueuePollingManager *)manager;
- (void)sessionQueuePollingManagerDidCancelPolling:(KUSSessionQueuePollingManager *)manager;
- (void)sessionQueuePollingManager:(KUSSessionQueuePollingManager *)manager didReceiveError:(NSError *)error;
@end
