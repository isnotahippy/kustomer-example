//
//  KUSChatPlaceholderTableViewCell.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/22/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSChatPlaceholderTableViewCell.h"

#import "KUSColor.h"
#import "KUSLocalization.h"

@implementation KUSChatPlaceholderTableViewCell

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSChatPlaceholderTableViewCell class]) {
        KUSChatPlaceholderTableViewCell *appearance = [KUSChatPlaceholderTableViewCell appearance];
        [appearance setBackgroundColor:[UIColor whiteColor]];
        [appearance setLineColor:[KUSColor lightGrayColor]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

#pragma mark - UIView methods

- (void)drawRect:(CGRect)rect
{
    BOOL isRTL = [[KUSLocalization sharedInstance] isCurrentLanguageRTL];
    [self.lineColor setFill];

    CGFloat margins = 28.0;
    CGFloat barHeight = 10.0;
    CGFloat barPadding = 8.0;
    CGFloat maxBarWidth = rect.size.width - margins * 2.0;

    CGFloat totalBarHeight = barHeight * 3.0 + barPadding * 2.0;
    CGFloat yOffset = (rect.size.height - totalBarHeight) / 2.0;

    UIRectFillUsingBlendMode((CGRect) {
        .origin.x = isRTL ? maxBarWidth - (maxBarWidth * 0.15) + margins : margins,
        .origin.y = yOffset,
        .size.width = maxBarWidth * 0.15,
        .size.height = 10.0
    }, kCGBlendModeNormal);

    UIRectFillUsingBlendMode((CGRect) {
        .origin.x = isRTL ? maxBarWidth - (maxBarWidth * 0.98) + margins : margins,
        .origin.y = yOffset + barHeight + barPadding,
        .size.width = maxBarWidth * 0.98,
        .size.height = 10.0
    }, kCGBlendModeNormal);

    UIRectFillUsingBlendMode((CGRect) {
        .origin.x = isRTL ? maxBarWidth - (maxBarWidth * 0.8) + margins : margins,
        .origin.y = yOffset + (barHeight + barPadding) * 2.0,
        .size.width = maxBarWidth * 0.8,
        .size.height = 10.0
    }, kCGBlendModeNormal);
}

#pragma mark - UIAppearance methods

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

@end
