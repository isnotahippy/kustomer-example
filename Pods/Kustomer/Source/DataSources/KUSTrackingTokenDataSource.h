//
//  KUSTrackingTokenDataSource.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/13/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSObjectDataSource.h"

#import "KUSTrackingToken.h"

@interface KUSTrackingTokenDataSource : KUSObjectDataSource

- (nullable NSString *)currentTrackingToken;

- (void)reset;

@end
