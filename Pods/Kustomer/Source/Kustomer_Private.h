//
//  Kustomer_Private.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/2/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "Kustomer.h"

#import "KUSLog.h"

@class KUSUserSession;
@interface Kustomer (Private)

@property (class, nonatomic, copy) NSString *hostDomain;
@property (class, nonatomic, assign) KUSLogOptions logOptions;

+ (instancetype)sharedInstance;

- (KUSUserSession *)userSession;

@end
