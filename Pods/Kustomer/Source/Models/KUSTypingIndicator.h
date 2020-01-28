//
//  KUSTypingIndicator.h
//  Kustomer
//
//  Created by Hunain Shahid on 17/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSModel.h"

typedef NS_ENUM(NSInteger, KUSTypingStatus) {
    KUSTyping,
    KUSTypingEnded,
    KUSTypingUnknown,
};

@interface KUSTypingIndicator : KUSModel

@property (nonatomic, copy, readonly) NSString *userId;
@property (nonatomic, assign, readwrite) KUSTypingStatus typingStatus;
@end
