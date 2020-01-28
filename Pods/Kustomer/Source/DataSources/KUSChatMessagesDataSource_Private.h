//
//  KUSChatMessagesDataSource_Private.h
//  Kustomer
//
//  Created by BrainX Technologies on 25/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSChatMessagesDataSource.h"

@interface KUSChatMessagesDataSource (Private)

- (void)mayGetSatisfactionFormIfAgentJoined;
- (void)notifyAnnouncersDidEndChatSession;

@end
