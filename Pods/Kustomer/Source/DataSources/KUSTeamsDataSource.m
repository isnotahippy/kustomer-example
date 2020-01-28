//
//  KUSTeamsDataSource.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/20/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSTeamsDataSource.h"
#import "KUSPaginatedDataSource_Private.h"

@interface KUSTeamsDataSource () {
    NSArray<NSString *> *_teamIds;
}

@end

@implementation KUSTeamsDataSource

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession teamIds:(NSArray<NSString *> *)teamIds
{
    self = [super initWithUserSession:userSession];
    if (self) {
        _teamIds = [teamIds copy];
    }
    return self;
}

- (NSArray<NSString *> *)teamIds
{
    return _teamIds;
}

#pragma mark - KUSPaginatedDataSource subclass methods

- (NSURL *)firstURL
{
    NSString *endpoint = [NSString stringWithFormat:@"/c/v1/chat/teams/%@", [_teamIds componentsJoinedByString:@","]];
    return [self.userSession.requestManager URLForEndpoint:endpoint];
}

- (Class)modelClass
{
    return [KUSTeam class];
}

@end
