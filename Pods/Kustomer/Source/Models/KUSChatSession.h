//
//  KUSChatSession.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSModel.h"

@class KUSChatMessage;
@interface KUSChatSession : KUSModel

@property (nonatomic, copy, readonly) NSString *preview;
@property (nonatomic, copy, readonly) NSString *trackingId;

@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readwrite) NSDate *lastSeenAt;
@property (nonatomic, copy, readonly) NSDate *lastMessageAt;
@property (nonatomic, copy, readwrite) NSDate *lockedAt;

@property (nonatomic, copy, readonly) NSString *satisfactionId;
@property (nonatomic, copy, readonly) NSString *satisfactionStatus;
@property (nonatomic, copy, readonly) NSDate *satisfactionLockedAt;

+ (KUSChatSession *)tempSessionFromChatMessage:(KUSChatMessage *)message;

@end
