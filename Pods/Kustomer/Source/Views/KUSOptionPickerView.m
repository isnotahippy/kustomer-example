//
//  KUSOptionPickerView.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/29/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSOptionPickerView.h"

#import "KUSColor.h"
#import "KUSImage.h"
#import "KUSFadingButton.h"

static const CGFloat kKUSOptionPickerViewMinimumHeight = 60.0;
static const CGFloat kKUSOptionPickerViewButtonPadding = 10.0;
static const CGFloat kKUSOptionPickerViewMinimumButtonHeight = kKUSOptionPickerViewMinimumHeight - kKUSOptionPickerViewButtonPadding * 2.0;
static const CGFloat kKUSOptionPickerViewMinimumButtonWidth = 100.0;

@interface KUSOptionPickerView () {
    UIView *_separatorView;
    UIActivityIndicatorView *_loadingView;

    NSArray<UIButton *> *_optionButtons;
    CGFloat contentViewHeight;
}

@end

@implementation KUSOptionPickerView

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSOptionPickerView class]) {
        KUSOptionPickerView *appearance = [KUSOptionPickerView appearance];
        [appearance setBackgroundColor:[UIColor whiteColor]];
        [appearance setSeparatorColor:[KUSColor lightGrayColor]];

        UIColor *textColor = [[KUSColor blueColor] colorWithAlphaComponent:0.8];
        [appearance setBorderColor:textColor];
        [appearance setTextColor:textColor];
        [appearance setTextFont:[UIFont systemFontOfSize:14.0]];
        [appearance setButtonColor:[UIColor colorWithWhite:0.975 alpha:1.0]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _separatorView = [[UIView alloc] init];
        _separatorView.userInteractionEnabled = NO;
        [self addSubview:_separatorView];

        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingView.hidesWhenStopped = YES;
        [_loadingView startAnimating];
        [self addSubview:_loadingView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _separatorView.frame = (CGRect) {
        .size.width = self.bounds.size.width,
        .size.height = 1.0
    };

    _loadingView.center = (CGPoint) {
        .x = self.bounds.size.width / 2.0,
        .y = self.bounds.size.height / 2.0
    };
    
    self.contentSize = CGSizeMake(self.bounds.size.width, contentViewHeight);

    CGPoint buttonOffset = CGPointMake(kKUSOptionPickerViewButtonPadding, kKUSOptionPickerViewButtonPadding);
    CGFloat previousButtonHeight = 0.0;
    for (UIButton *button in _optionButtons) {
        CGSize buttonSize = [self _sizeForButton:button];
        CGFloat buttonMaxX = buttonOffset.x + buttonSize.width + kKUSOptionPickerViewButtonPadding;

        if (buttonMaxX > self.bounds.size.width) {
            buttonOffset.x = kKUSOptionPickerViewButtonPadding;
            buttonOffset.y += previousButtonHeight + kKUSOptionPickerViewButtonPadding;
        }

        button.frame = (CGRect) {
            .origin = buttonOffset,
            .size = buttonSize
        };
        buttonOffset.x += kKUSOptionPickerViewButtonPadding + buttonSize.width;
        previousButtonHeight = buttonSize.height;
    }
}

#pragma mark - Public methods

- (CGFloat)desiredHeight
{
    CGPoint buttonOffset = CGPointMake(kKUSOptionPickerViewButtonPadding, kKUSOptionPickerViewButtonPadding);
    CGFloat previousButtonHeight = 0.0;
    for (UIButton *button in _optionButtons) {
        CGSize buttonSize = [self _sizeForButton:button];
        CGFloat buttonMaxX = buttonOffset.x + buttonSize.width + kKUSOptionPickerViewButtonPadding;

        if (buttonMaxX > self.bounds.size.width) {
            buttonOffset.x = kKUSOptionPickerViewButtonPadding;
            buttonOffset.y += previousButtonHeight + kKUSOptionPickerViewButtonPadding;
        }
        buttonOffset.x += kKUSOptionPickerViewButtonPadding + buttonSize.width;
        previousButtonHeight = buttonSize.height;
    }
    contentViewHeight = MAX(kKUSOptionPickerViewMinimumHeight, buttonOffset.y + previousButtonHeight + kKUSOptionPickerViewButtonPadding);
    CGFloat mainScreenHeight = [UIScreen mainScreen].bounds.size.height;
    return MIN(contentViewHeight, mainScreenHeight/2);
}

- (void)setOptions:(NSArray<NSString *> *)options
{
    _options = options;
    if (_options.count) {
        [_loadingView stopAnimating];
    } else {
        [_loadingView startAnimating];
    }
    [self _rebuildOptionButtons];
}

#pragma mark - Internal methods

- (CGSize)_sizeForButton:(UIButton *)button
{
    CGSize buttonSize = [button sizeThatFits:button.bounds.size];
    buttonSize.width = MAX(round(buttonSize.width) + kKUSOptionPickerViewButtonPadding * 2.0, kKUSOptionPickerViewMinimumButtonWidth);
    buttonSize.width = MIN(buttonSize.width, self.bounds.size.width - kKUSOptionPickerViewButtonPadding * 2.0);
    buttonSize.height = MAX(round(buttonSize.height) + kKUSOptionPickerViewButtonPadding, kKUSOptionPickerViewMinimumButtonHeight);
    return buttonSize;
}

- (void)_rebuildOptionButtons
{
    for (UIButton *button in _optionButtons) {
        [button removeFromSuperview];
    }

    NSMutableArray<UIButton *> *optionButtons = [[NSMutableArray alloc] initWithCapacity:self.options.count];

    for (NSString *option in self.options) {
        UIButton *button = [[KUSFadingButton alloc] init];
        button.backgroundColor = self.buttonColor;
        button.layer.cornerRadius = 5.0;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = self.borderColor.CGColor;
        button.titleLabel.font = self.textFont;
        [button setTitle:option forState:UIControlStateNormal];
        [button setTitleColor:self.textColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_onButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [optionButtons addObject:button];
        [self addSubview:button];
    }

    _optionButtons = optionButtons;
    [self setNeedsLayout];
}

- (void)_onButtonPress:(UIButton *)button
{
    NSUInteger indexOfButton = [_optionButtons indexOfObject:button];
    if (indexOfButton != NSNotFound) {
        NSString *option = self.options[indexOfButton];
        if ([self.delegate respondsToSelector:@selector(optionPickerView:didSelectOption:)]) {
            [self.delegate optionPickerView:self didSelectOption:option];
        }
    }
}

#pragma mark - UIAppearance methods

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    _separatorView.backgroundColor = _separatorColor;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self _rebuildOptionButtons];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self _rebuildOptionButtons];
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    [self _rebuildOptionButtons];
}

- (void)setButtonColor:(UIColor *)buttonColor
{
    _buttonColor = buttonColor;
    [self _rebuildOptionButtons];
}

@end
