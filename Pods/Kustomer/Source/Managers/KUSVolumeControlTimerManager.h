//
//  KUSVolumeControlTimerManager.h
//  Kustomer
//
//  Created by BrainX Technologies on 01/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KUSTimer.h"

@protocol KUSVolumeControlTimerListener;
@interface KUSVolumeControlTimerManager : NSObject

+ (KUSVolumeControlTimerManager *)sharedInstance;
- (void)createVolumeControlTimerForSession:(NSString *)sessionId listener:(id<KUSVolumeControlTimerListener>)listener delay:(NSTimeInterval)delay;
- (void)resumeVCTimerForSession:(NSString *)sessionId;
- (void)invalidateVCTimerForSession:(NSString *)sessionId;
- (void)pauseVCTimers;
- (void)resumeVCTimers;
- (void)invalidateVCTimers;
- (BOOL)sessionHasVCTimer:(NSString *)sessionId;
- (BOOL)hasVCTimers;
- (void)reset;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

@protocol KUSVolumeControlTimerListener <NSObject>

- (void)volumeControlTimerDidComplete:(KUSTimer *)timer;

@end
