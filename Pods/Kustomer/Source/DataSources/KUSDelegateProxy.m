//
//  KUSDelegateProxy.m
//  Kustomer
//
//  Created by Daniel Amitay on 9/19/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSDelegateProxy.h"

@interface KUSDelegateProxy ()

@property (nonatomic, weak) id<KustomerDelegate> delegate;

@end

@implementation KUSDelegateProxy

- (BOOL)shouldDisplayInAppNotification
{
    if ([self.delegate respondsToSelector:@selector(kustomerShouldDisplayInAppNotification)]) {
        return [self.delegate kustomerShouldDisplayInAppNotification];
    }
    return YES;
}

- (void)didTapOnInAppNotification
{
    if ([self.delegate respondsToSelector:@selector(kustomerDidTapOnInAppNotification)]) {
        [self.delegate kustomerDidTapOnInAppNotification];
    } else {
        [Kustomer presentSupport];
    }
}

@end
