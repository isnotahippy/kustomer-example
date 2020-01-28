//
//  KUSTextView.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/24/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSTextView.h"

#import <MobileCoreServices/UTCoreTypes.h>

@interface KUSTextView () {
    UILabel *_placeholderLabel;
}

@end

@implementation KUSTextView
@dynamic delegate;

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSTextView class]) {
        KUSTextView *appearance = [KUSTextView appearance];
        [appearance setPlaceholderColor:[UIColor lightGrayColor]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.editable = YES;
        self.selectable = YES;
        self.scrollEnabled = YES;
        self.scrollsToTop = NO;
        self.directionalLockEnabled = YES;
        self.dataDetectorTypes = UIDataDetectorTypeNone;

        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.clipsToBounds = NO;
        _placeholderLabel.numberOfLines = 1;
        _placeholderLabel.autoresizesSubviews = NO;
        _placeholderLabel.font = self.font;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.hidden = YES;
        _placeholderLabel.isAccessibilityElement = NO;
        [self addSubview:_placeholderLabel];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_didChangeText:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View methods

- (void)layoutSubviews
{
    [super layoutSubviews];

    _placeholderLabel.hidden = [self _shouldHidePlaceholder];
    _placeholderLabel.frame = [self _placeholderRect];
}

- (CGSize)intrinsicContentSize
{
    CGFloat height = self.font.lineHeight + self.textContainerInset.top + self.textContainerInset.bottom;
    return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

#pragma mark - Property methods

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholderLabel.text = placeholder;
    [self setNeedsLayout];
}

- (NSString *)placeholder
{
    return _placeholderLabel.text;
}

- (NSUInteger)maxNumberOfLines
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsPortrait(orientation) ? 4 : 3;
}

- (NSUInteger)numberOfLines
{
    CGSize contentSize = self.contentSize;
    CGFloat contentHeight = contentSize.height - (self.textContainerInset.top + self.textContainerInset.bottom);

    NSUInteger lines = fabs(contentHeight / self.font.lineHeight);
    if (lines == 1 && contentSize.height > self.bounds.size.height) {
        contentSize.height = self.bounds.size.height;
        self.contentSize = contentSize;
    }

    return MAX(lines, 1);
}

- (CGFloat)desiredHeight
{
    CGFloat height = [self _heightForLines:MIN(self.numberOfLines, self.maxNumberOfLines)];
    CGFloat minimumHeight = self.intrinsicContentSize.height;
    return roundf(MAX(height, minimumHeight));
}

#pragma mark - Internal state methods

- (CGFloat)_heightForLines:(NSUInteger)numberOfLines
{
    CGFloat height = self.intrinsicContentSize.height;
    height -= self.font.lineHeight;
    height += roundf(self.font.lineHeight * numberOfLines);
    height += self.contentInset.top;
    height += self.contentInset.bottom;
    return height + 1.0;
}

- (CGRect)_placeholderRect
{
    CGFloat padding = self.textContainer.lineFragmentPadding;
    CGPoint containerOrigin = UIEdgeInsetsInsetRect(self.bounds, self.textContainerInset).origin;
    return (CGRect) {
        .origin.x = containerOrigin.x + padding,
        .origin.y = containerOrigin.y,
        .size.width = self.textContainer.size.width - padding * 2.0,
        .size.height = [_placeholderLabel sizeThatFits:self.bounds.size].height
    };
}

- (BOOL)_shouldHidePlaceholder
{
    if (self.placeholder.length == 0 || self.text.length > 0) {
        return YES;
    }
    return NO;
}

#pragma mark - UITextView method overrides

- (void)setContentOffset:(CGPoint)contentOffset
{
    CGFloat yOffset = contentOffset.y;
    if (self.bounds.size.height >= self.contentSize.height) {
        yOffset = 0.0;
    }
    [super setContentOffset:CGPointMake(0.0, yOffset)];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [_placeholderLabel setFont:font];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsLayout];
}

#pragma mark - NSNotificationCenter methods

- (void)_didChangeText:(NSNotification *)notification
{
    if (_placeholderLabel.hidden != [self _shouldHidePlaceholder]) {
        [self setNeedsLayout];
    }
}

#pragma mark - UIAppearance methods

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    _placeholderLabel.textColor = _placeholderColor;
}

#pragma mark - Image pasting support

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:)
        && [self.delegate respondsToSelector:@selector(textViewCanPasteImage:)]
        && [self.delegate textViewCanPasteImage:self]
        && [self _imageFromPasteboard]) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)paste:(id)sender
{
    BOOL canPasteImage = ([self.delegate respondsToSelector:@selector(textViewCanPasteImage:)]
                          && [self.delegate textViewCanPasteImage:self]
                          && [self.delegate respondsToSelector:@selector(textView:didPasteImage:)]);
    if (canPasteImage) {
        UIImage *pastedImage = [self _imageFromPasteboard];
        if (pastedImage) {
            [self.delegate textView:self didPasteImage:pastedImage];
            return;
        }
    }
    [super paste:sender];
}

- (UIImage *)_imageFromPasteboard
{
    NSData *pasteboardData = [[UIPasteboard generalPasteboard] dataForPasteboardType:(NSString *)kUTTypeImage];
    return [UIImage imageWithData:pasteboardData];
}

@end
