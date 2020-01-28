//
//  KUSNewSessionButton.m
//  Kustomer
//
//  Created by Daniel Amitay on 9/5/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSNewSessionButton.h"

#import "KUSColor.h"
#import "KUSImage.h"
#import "KUSLocalization.h"
#import "KUSUserSession.h"

static const CGFloat kMinimumSessionButtonWidth = 180.0;
static const CGFloat kSessionButtonEdgePadding = 20.0;
static const CGFloat kSessionButtonHeight = 44.0;

@interface KUSNewSessionButton () <KUSObjectDataSourceListener, KUSPaginatedDataSourceListener> {
    KUSUserSession *_userSession;
    
    BOOL isAlreadyLoaded;
}
@end

@implementation KUSNewSessionButton

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSNewSessionButton class]) {
        KUSNewSessionButton *appearance = [KUSNewSessionButton appearance];
        [appearance setColor:[KUSColor blueColor]];
        [appearance setImage:[KUSImage pencilImage]];
        [appearance setTextColor:[UIColor whiteColor]];
        [appearance setTextFont:[UIFont systemFontOfSize:14.0]];
        [appearance setHasShadow:YES];
        [appearance setText:[[KUSLocalization sharedInstance] localizedString:@"New Conversation"]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession
{
    self = [super init];
    if (self) {
        _userSession = userSession;
        isAlreadyLoaded = NO;
        
        [_userSession.chatSessionsDataSource addListener:self];
        [_userSession.chatSettingsDataSource addListener:self];
        [_userSession.scheduleDataSource addListener:self];
        [self updateButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!isAlreadyLoaded) {
        isAlreadyLoaded = YES;
        [self updateButton];
    }
}

- (CGSize)intrinsicContentSize
{
    CGSize maxSize = CGSizeMake(self.window.bounds.size.width - kSessionButtonEdgePadding * 2.0, kSessionButtonHeight);
    CGSize sizeThatFits = [self sizeThatFits:maxSize];
    CGFloat buttonWidth = MAX(ceil(sizeThatFits.width) + kSessionButtonEdgePadding * 2.0, kMinimumSessionButtonWidth);
    return CGSizeMake(buttonWidth, kSessionButtonHeight);
}

#pragma mark - Internal methods



- (void)_updateImageAndInsets:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
    if ([[KUSLocalization sharedInstance] isCurrentLanguageRTL]) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, self.imageView.frame.size.width + 5.0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, self.titleLabel.frame.size.width + self.imageView.frame.size.width + 10, 0.0, -self.titleLabel.frame.size.width)];
    }
    else {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 5.0)];
    }
}

#pragma mark - Public methods

- (void)updateButton
{
    if ([self isBackToChat]) {
        [self setTitle:[[KUSLocalization sharedInstance] localizedString:@"Back to chat"] forState:UIControlStateNormal];
        [self _updateImageAndInsets:[KUSImage noImage]];
    }
    else {
        if (![_userSession.scheduleDataSource isActiveBusinessHours]) {
            [self setTitle:[[KUSLocalization sharedInstance] localizedString:@"Leave a message"] forState:UIControlStateNormal];
            [self setImage:_image == nil ? [[KUSNewSessionButton appearance] image] : _image];
        }
        else {
            [self setText:_text == nil ? [[KUSNewSessionButton appearance] text] : _text];
            [self setImage:_image == nil ? [[KUSNewSessionButton appearance] image] : _image];
        }
    }
}

- (BOOL)isBackToChat
{
    KUSChatSettings *settings = [_userSession.chatSettingsDataSource object];
    return (settings.singleSessionChat && (_userSession.chatSessionsDataSource.openChatSessionsCount-_userSession.chatSessionsDataSource.openProactiveCampaignsCount) >= 1);
}

#pragma mark - KUSObjectDataSourceListener

- (void)objectDataSourceDidLoad:(KUSObjectDataSource *)dataSource
{
    [self updateButton];
}

#pragma mark - KUSPaginatedDataSourceListener methods

- (void)paginatedDataSourceDidChangeContent:(KUSPaginatedDataSource *)dataSource
{
    [self updateButton];
}

#pragma mark - UIAppearance methods

- (void)setColor:(UIColor *)color
{
    _color = color;
    if (color) {
        CGFloat buttonRadius = 4.0;
        CGSize size = CGSizeMake(buttonRadius * 2.0, buttonRadius * 2.0);
        UIImage *circularImage = [KUSImage circularImageWithSize:size color:_color];
        UIEdgeInsets capInsets = UIEdgeInsetsMake(buttonRadius, buttonRadius, buttonRadius, buttonRadius);
        UIImage *buttonImage = [circularImage resizableImageWithCapInsets:capInsets];
        [self setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    else {
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self _updateImageAndInsets:_image];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self setTitleColor:_textColor forState:UIControlStateNormal];
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    self.titleLabel.font = _textFont;
}

- (void)setHasShadow:(BOOL)hasShadow
{
    _hasShadow = hasShadow;
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.layer.shadowRadius = (_hasShadow ? 1.0 : 0.0);
    self.layer.shadowOpacity = (_hasShadow ? 0.5 : 0.0);
}

- (void)setText:(NSString *)text
{
    _text = text;
    [self setTitle:_text forState:UIControlStateNormal];
}

@end
