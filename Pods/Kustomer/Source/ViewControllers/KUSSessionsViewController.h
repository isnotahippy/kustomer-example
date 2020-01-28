//
//  KUSSessionsViewController.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/16/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSBaseViewController.h"

@class KUSUserSession;
@interface KUSSessionsViewController : KUSBaseViewController

- (instancetype)initWithUserSession:(KUSUserSession *)userSession;
- (instancetype)init NS_UNAVAILABLE;

@end
