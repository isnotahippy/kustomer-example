//
//  KUSClosedChatView.m
//  Kustomer
//
//  Created by Hunain Shahid on 01/06/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSClosedChatView.h"

#import "KUSColor.h"
#import "KUSLocalization.h"

@interface KUSClosedChatView ()

@property (nonatomic, strong) UILabel *infoLabel;
@end

@implementation KUSClosedChatView

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSClosedChatView class]) {
        KUSClosedChatView *appearance = [KUSClosedChatView appearance];
        [appearance setBackgroundColor:[KUSColor lightGrayColor]];
        [appearance setLabelColor:[UIColor darkGrayColor]];
        [appearance setLabelFont:[UIFont boldSystemFontOfSize:14.0]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.text = [[KUSLocalization sharedInstance] localizedString:@"Thank You! We'll follow up on your request."];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.adjustsFontSizeToFitWidth = YES;
        self.infoLabel.minimumScaleFactor = 10.0 / 12.0;
        self.infoLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.infoLabel];
    }
    return self;
}

#pragma mark - View methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize infoLabelSize = [self.infoLabel sizeThatFits:self.bounds.size];
    infoLabelSize.width = ceil(infoLabelSize.width);
    infoLabelSize.height = ceil(infoLabelSize.height);
    self.infoLabel.frame = (CGRect) {
        .origin.x = (self.bounds.size.width - infoLabelSize.width) / 2.0,
        .origin.y = (self.bounds.size.height - infoLabelSize.height) / 2.0,
        .size = infoLabelSize
    };
}

#pragma mark - UIAppearance methods

- (void)setLabelColor:(UIColor *)promptColor
{
    _labelColor = promptColor;
    self.infoLabel.textColor = _labelColor;
}

- (void)setLabelFont:(UIFont *)promptFont
{
    _labelFont = promptFont;
    self.infoLabel.font = _labelFont;
}

@end
