//
//  KUSAttributionToolbar.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSAttributionToolbar.h"

#import "KUSColor.h"
#import "KUSLocalization.h"

@interface KUSAttributionToolbar ()

@property (nonatomic, strong) UILabel *attributionLabel;

@end

@implementation KUSAttributionToolbar

#pragma mark - Lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translucent = NO;
        self.barTintColor = [KUSColor lightGrayColor];

        _attributionLabel = [[UILabel alloc] init];
        _attributionLabel.text = @"Messaging by Kustomer";
        _attributionLabel.textAlignment = NSTextAlignmentCenter;
        _attributionLabel.backgroundColor = [UIColor clearColor];
        _attributionLabel.textColor = [KUSColor darkGrayColor];
        _attributionLabel.font = [UIFont systemFontOfSize:9.0];
        [self addSubview:_attributionLabel];
    }
    return self;
}

#pragma mark - UIView methods

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize attributionLabelSize = [self.attributionLabel sizeThatFits:self.bounds.size];
    attributionLabelSize.width = ceil(attributionLabelSize.width);
    attributionLabelSize.height = ceil(attributionLabelSize.height);
    self.attributionLabel.frame = (CGRect) {
        .origin.x = (self.bounds.size.width - attributionLabelSize.width) / 2.0,
        .origin.y = (self.bounds.size.height - attributionLabelSize.height) / 2.0,
        .size = attributionLabelSize
    };
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize superSize = [super sizeThatFits:size];
    superSize.height = 18.0;
    return superSize;
}

@end
