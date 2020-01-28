//
//  KUSClientActivityDataSource.m
//  Kustomer
//
//  Created by Daniel Amitay on 2/11/18.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSClientActivityDataSource.h"

#import "KUSObjectDataSource_Private.h"

@implementation KUSClientActivityDataSource {
    NSString *_previousPageName;
    NSString *_currentPageName;
    NSTimeInterval _currentPageSeconds;
}

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession
                   previousPageName:(NSString *)previousPageName
                    currentPageName:(NSString *)currentPageName
                 currentPageSeconds:(NSTimeInterval)currentPageSeconds
{
    self = [super initWithUserSession:userSession];
    if (self) {
        NSAssert(currentPageName, @"Should not fetch client activity without a current page!");
        _previousPageName = [previousPageName copy];
        _currentPageName = [currentPageName copy];
        _currentPageSeconds = currentPageSeconds;
    }
    return self;
}

#pragma mark - Public methods

- (NSArray<NSNumber *> *)intervals
{
    KUSClientActivity *clientActivity = (KUSClientActivity *)self.object;
    return clientActivity.intervals;
}

- (NSDate *)createdAt
{
    KUSClientActivity *clientActivity = (KUSClientActivity *)self.object;
    return clientActivity.createdAt;
}

- (NSTimeInterval)currentPageSeconds
{
    KUSClientActivity *clientActivity = (KUSClientActivity *)self.object;
    return clientActivity.currentPageSeconds;
}

#pragma mark - KUSObjectDataSource subclass methods

- (void)performRequestWithCompletion:(KUSRequestCompletion)completion
{
    NSMutableDictionary<NSString *, NSObject *> *params = [[NSMutableDictionary alloc] initWithCapacity:3];
    if (_previousPageName) {
        [params setObject:_previousPageName forKey:@"previousPage"];
    }
    [params setObject:_currentPageName forKey:@"currentPage"];
    [params setObject:[NSNumber numberWithDouble:_currentPageSeconds] forKey:@"currentPageSeconds"];
    [self.userSession.requestManager performRequestType:KUSRequestTypePost
                                               endpoint:@"/c/v1/client-activity"
                                                 params:params
                                          authenticated:YES
                                             completion:completion];
}

- (Class)modelClass
{
    return [KUSClientActivity class];
}

@end
