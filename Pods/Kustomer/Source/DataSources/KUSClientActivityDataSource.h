//
//  KUSClientActivityDataSource.h
//  Kustomer
//
//  Created by Daniel Amitay on 2/11/18.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSObjectDataSource.h"
#import "KUSClientActivity.h"

@interface KUSClientActivityDataSource : KUSObjectDataSource

- (instancetype)initWithUserSession:(KUSUserSession *)userSession
                   previousPageName:(NSString *)previousPageName
                    currentPageName:(NSString *)currentPageName
                 currentPageSeconds:(NSTimeInterval)currentPageSeconds;
- (instancetype)initWithUserSession:(KUSUserSession *)userSession NS_UNAVAILABLE;

- (NSArray<NSNumber *> *)intervals;
- (NSDate *)createdAt;
- (NSTimeInterval)currentPageSeconds;

@end
