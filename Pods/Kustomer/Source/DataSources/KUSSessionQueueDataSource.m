//
//  KUSSessionQueueDataSource.m
//  Kustomer
//
//  Created by Hunain Shahid on 06/11/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSSessionQueueDataSource.h"
#import "KUSObjectDataSource_Private.h"

@interface KUSSessionQueueDataSource () {
    NSString *_sessionId;
}

@end

@implementation KUSSessionQueueDataSource

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession sessionId:(NSString *)sessionId
{
    self = [super initWithUserSession:userSession];
    if (self) {
        _sessionId = sessionId;
    }
    return self;
}

#pragma mark - KUSObjectDataSource subclass methods

- (void)performRequestWithCompletion:(KUSRequestCompletion)completion
{
    NSString *endpoint = [NSString stringWithFormat:@"/c/v1/chat/sessions/%@/queue", _sessionId];
    [self.userSession.requestManager getEndpoint:endpoint
                                   authenticated:YES
                                      completion:completion];
}

- (Class)modelClass
{
    return [KUSSessionQueue class];
}

@end
