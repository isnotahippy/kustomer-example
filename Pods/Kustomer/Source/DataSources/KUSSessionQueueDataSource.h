//
//  KUSSessionQueueDataSource.h
//  Kustomer
//
//  Created by Hunain Shahid on 06/11/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSObjectDataSource.h"
#import "KUSSessionQueue.h"

@interface KUSSessionQueueDataSource : KUSObjectDataSource

- (instancetype)initWithUserSession:(KUSUserSession *)userSession sessionId:(NSString *)sessionId;
- (instancetype)initWithUserSession:(KUSUserSession *)userSession NS_UNAVAILABLE;

@end
