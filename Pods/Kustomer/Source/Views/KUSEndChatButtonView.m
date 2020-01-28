//
//  KUSCloseChatButtonView.m
//  Kustomer
//
//  Created by BrainX Technologies on 28/06/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KUSEndChatButtonView.h"
#import "KUSLocalization.h"
#import "KUSImage.h"

static const CGFloat kEndButtonEdgePadding = 10.0;
static const CGFloat kEndButtonHeight = 30.0;

@interface KUSEndChatButtonView()

@property (nonatomic, strong) UIButton *closeChatButton;

@end

@implementation KUSEndChatButtonView

#pragma mark - Class methods
+ (void)initialize
{
    if (self == [KUSEndChatButtonView class]) {
        KUSEndChatButtonView *appearance = [KUSEndChatButtonView appearance];
        [appearance setBackgroundColor:[UIColor whiteColor]];
        [appearance setTextColor:[UIColor blackColor]];
        [appearance setTextFont:[UIFont systemFontOfSize:13]];
        [appearance setBorderColor:[UIColor lightGrayColor]];
        [appearance setText:[[KUSLocalization sharedInstance] localizedString:@"END CHAT"]];
    }
}

#pragma mark - Lifecycle methods
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.closeChatButton = [[UIButton alloc] init];
        self.closeChatButton.layer.cornerRadius = 15;
        self.closeChatButton.layer.borderWidth = 1.0f;
        [self.closeChatButton addTarget:self
                   action:@selector(buttonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: self.closeChatButton];
    }
    return self;
}

#pragma mark - View methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize maxSize = CGSizeMake(self.window.bounds.size.width - kEndButtonEdgePadding * 2.0, kEndButtonHeight);
    CGSize sizeThatFits = [_closeChatButton sizeThatFits:maxSize];
    CGFloat buttonWidth = MIN(ceil(sizeThatFits.width) + kEndButtonEdgePadding * 2.0, maxSize.width);

    self.closeChatButton.frame = (CGRect) {
        .size.width = buttonWidth,
        .size.height = 30
    };
    [self.closeChatButton setCenter: CGPointMake(self.bounds.size.width - ((buttonWidth / 2) + kEndButtonEdgePadding), self.bounds.size.height / 2)];
}

#pragma mark - Action methods

- (void)buttonPressed:(UIButton *)button
{
    [_delegate closeChatButtonTapped:self];
}

#pragma mark - UIAppearance methods

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundColor = backgroundColor;
    
    CGFloat buttonRadius = kEndButtonHeight / 2;
    CGSize size = CGSizeMake(buttonRadius * 2.0, buttonRadius * 2.0);
    UIImage *circularImage = [KUSImage circularImageWithSize:size color:backgroundColor];
    UIEdgeInsets capInsets = UIEdgeInsetsMake(buttonRadius, buttonRadius, buttonRadius, buttonRadius);
    UIImage *buttonImage = [circularImage resizableImageWithCapInsets:capInsets];
    [_closeChatButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [_closeChatButton setTitleColor:_textColor forState:UIControlStateNormal];
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    _closeChatButton.titleLabel.font = _textFont;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    _closeChatButton.layer.borderColor = _borderColor.CGColor;
}

- (void)setText:(NSString *)text
{
    _text = text;
    [_closeChatButton setTitle:_text forState:UIControlStateNormal];
}
@end

