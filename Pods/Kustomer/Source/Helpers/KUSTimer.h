//
//  KUSTimer.h
//  Kustomer
//
//  Created by Daniel Amitay on 2/21/18.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KUSTimer : NSObject

// The underlying NSTimer
@property (nonatomic, strong, readonly) NSTimer *timer;
@property (nonatomic, strong) id userInfo;

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeats;

- (NSTimeInterval)timeInterval;
- (void)fire;
- (void)invalidate;
- (void)resume;
- (void)pause;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
