//
//  KUSTeamsDataSource.h
//  Kustomer
//
//  Created by Daniel Amitay on 12/20/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSPaginatedDataSource.h"
#import "KUSTeam.h"

@interface KUSTeamsDataSource : KUSPaginatedDataSource

- (instancetype)initWithUserSession:(KUSUserSession *)userSession teamIds:(NSArray<NSString *> *)teamIds;
- (instancetype)initWithUserSession:(KUSUserSession *)userSession NS_UNAVAILABLE;

- (NSArray<NSString *> *)teamIds;

@end
