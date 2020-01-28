//
//  KUSFadingButton.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/30/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSFadingButton.h"

static const CGFloat kKUSFadingButtonFadedAlpha = 0.6;

@implementation KUSFadingButton

#pragma mark - Lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAdjustsImageWhenHighlighted:NO];
        [self addTarget:self action:@selector(_onTouchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(_onTouchDown) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(_onTouchUp) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(_onTouchUp) forControlEvents:UIControlEventTouchDragExit];
        [self addTarget:self action:@selector(_onTouchUp) forControlEvents:UIControlEventTouchCancel];
    }
    return self;
}

#pragma mark - Interface element methods

- (void)_onTouchDown
{
    self.alpha = kKUSFadingButtonFadedAlpha;
}

- (void)_onTouchUp
{
    self.alpha = 1.0;
}

@end
