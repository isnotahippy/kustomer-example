//
//  KUSReachabilityManager.h
//  Kustomer
//
//  Created by BrainX Technologies on 25/03/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    KUSNetworkConnectionStateNotConnected = 0,
    KUSNetworkConnectionStateConnected,
    KUSNetworkConnectionStateUndefined
} KUSNetworkConnectionState;

@interface KUSReachabilityManager : NSObject

+ (KUSReachabilityManager *)sharedInstance;
- (void)startObservingNetworkChange;
- (void)stopObservingNetworkChange;
- (KUSNetworkConnectionState)networkConnectionState;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
