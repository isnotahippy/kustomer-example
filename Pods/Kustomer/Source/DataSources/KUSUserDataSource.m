//
//  KUSUserDataSource.m
//  Kustomer
//
//  Created by Daniel Amitay on 8/18/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSUserDataSource.h"

#import "KUSObjectDataSource_Private.h"

@interface KUSUserDataSource () {
    NSString *_userId;
}

@end

@implementation KUSUserDataSource

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession userId:(NSString *)userId
{
    self = [super initWithUserSession:userSession];
    if (self) {
        _userId = userId;
    }
    return self;
}

#pragma mark - KUSObjectDataSource subclass methods

- (void)performRequestWithCompletion:(KUSRequestCompletion)completion
{
    NSString *endpoint = [NSString stringWithFormat:@"/c/v1/users/%@", _userId];
    [self.userSession.requestManager getEndpoint:endpoint
                                   authenticated:YES
                                      completion:completion];
}

- (Class)modelClass
{
    return [KUSUser class];
}

@end
