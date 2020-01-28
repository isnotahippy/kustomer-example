//
//  KUSUserDataSource.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/18/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSObjectDataSource.h"

#import "KUSUser.h"

@interface KUSUserDataSource : KUSObjectDataSource

- (instancetype)initWithUserSession:(KUSUserSession *)userSession userId:(NSString *)userId;
- (instancetype)initWithUserSession:(KUSUserSession *)userSession NS_UNAVAILABLE;

@end
