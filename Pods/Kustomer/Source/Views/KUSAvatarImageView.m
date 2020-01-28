//
//  KUSAvatarImageView.m
//  Kustomer
//
//  Created by Daniel Amitay on 8/15/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSAvatarImageView.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "KUSImage.h"
#import "KUSUser.h"
#import "KUSUserSession.h"

@interface KUSAvatarImageView () <KUSObjectDataSourceListener> {
    __weak KUSUserSession *_userSession;

    __weak KUSUserDataSource *_userDataSource;

    UIImageView *_staticImageView;
    UIImageView *_remoteImageView;
}

@end

@implementation KUSAvatarImageView

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        _userSession = userSession;
        [_userSession.chatSettingsDataSource addListener:self];

        _staticImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _staticImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_staticImageView];

        _remoteImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _remoteImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_remoteImageView];

        [self _updateAvatarImage];
    }
    return self;
}

#pragma mark - View methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    _staticImageView.frame = self.bounds;
    _remoteImageView.frame = self.bounds;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
}

#pragma mark - Property methods

- (void)setUserId:(NSString *)userId
{
    if (_userId == userId || [_userId isEqualToString:userId]) {
        return;
    }
    [_userDataSource removeListener:self];
    _userId = userId;
    _userDataSource = [_userSession userDataSourceForUserId:_userId];
    [_userDataSource addListener:self];
    [self _updateAvatarImage];
}

#pragma mark - Internal methods

- (void)_updateAvatarImage
{
    if (_userId == nil && self.companyAvatarImage) {
        _staticImageView.image = self.companyAvatarImage;
        [_remoteImageView sd_setImageWithURL:nil];
        return;
    }

    KUSUser *user = _userDataSource.object;
    if (_userDataSource && user == nil && !_userDataSource.isFetching) {
        [_userDataSource fetch];
    }
    KUSChatSettings *chatSettings = _userSession.chatSettingsDataSource.object;
    if (_userSession.chatSettingsDataSource && chatSettings == nil && !_userSession.chatSettingsDataSource.isFetching) {
        [_userSession.chatSettingsDataSource fetch];
    }

    // Render the default/fallback image into the static image view
    NSString *name = user.displayName ?: chatSettings.teamName ?: _userSession.organizationName;
    UIImage *placeholderImage = [KUSImage defaultAvatarImageForName:name];
    _staticImageView.image = placeholderImage;

    // Load the dynamic URL into the remote image view
    NSURL *iconURL = user.avatarURL ?: chatSettings.teamIconURL;
    [_remoteImageView sd_setImageWithURL:iconURL];
}

#pragma mark - KUSObjectDataSourceListener methods

- (void)objectDataSourceDidLoad:(KUSObjectDataSource *)dataSource
{
    if (dataSource == _userSession.chatSettingsDataSource) {
        [self _updateAvatarImage];
    } else if (dataSource == _userDataSource) {
        [self _updateAvatarImage];
    }
}

#pragma mark - UIAppearance methods

- (void)setCompanyAvatarImage:(UIImage *)companyAvatarImage
{
    _companyAvatarImage = companyAvatarImage;
    [self _updateAvatarImage];
}

@end
