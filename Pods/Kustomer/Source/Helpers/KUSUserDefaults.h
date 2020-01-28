//
//  KUSUserDefaults.h
//  Kustomer
//
//  Created by Daniel Amitay on 12/6/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KUSUserSession;
@interface KUSUserDefaults : NSObject

@property (nonatomic, assign) BOOL didCaptureEmail;
@property (nonatomic, copy, nullable) NSString *trackingToken;
@property (nonatomic, copy, nullable) NSString *formId;
@property (nonatomic, assign) NSInteger openChatSessionsCount;
@property (nonatomic, assign) BOOL shouldHideNewConversationButtonInClosedChat;

- (instancetype _Nonnull)initWithUserSession:(KUSUserSession * _Nonnull)userSession;
- (instancetype _Nonnull)init NS_UNAVAILABLE;
+ (instancetype _Nonnull)new NS_UNAVAILABLE;

- (void)reset;

@end
