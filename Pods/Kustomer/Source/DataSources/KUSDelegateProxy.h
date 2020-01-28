//
//  KUSDelegateProxy.h
//  Kustomer
//
//  Created by Daniel Amitay on 9/19/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Kustomer.h"

@interface KUSDelegateProxy : NSObject

- (void)setDelegate:(__weak id<KustomerDelegate>)delegate;

- (BOOL)shouldDisplayInAppNotification;
- (void)didTapOnInAppNotification;

@end
