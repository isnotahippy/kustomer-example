//
//  KUSNavigationController.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSNavigationController.h"

#import "KUSAttributionToolbar.h"
#import "KUSColor.h"
#import "Kustomer_Private.h"
#import "KUSUserSession.h"

@interface KUSNavigationController () <KUSObjectDataSourceListener, UIGestureRecognizerDelegate> {
    UIStatusBarStyle _preferredStatusBarStyle;
    UIInterfaceOrientationMask _supportedInterfaceOrientations;
}

@end

@implementation KUSNavigationController

#pragma mark - Lifecycle methods

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:nil toolbarClass:[KUSAttributionToolbar class]];
    if (self) {
        _preferredStatusBarStyle = UIStatusBarStyleDefault;
        _supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;

        KUSUserSession *_userSession = [Kustomer sharedInstance].userSession;
        if (_userSession.chatSettingsDataSource.didFetch) {
            KUSChatSettings *settings = [_userSession.chatSettingsDataSource object];
            [self setToolbarHidden:!settings.brandingKustomer];
        } else {
            [self setToolbarHidden:YES];
            [_userSession.chatSettingsDataSource addListener:self];
            [_userSession.chatSettingsDataSource fetch];
        }
        
        [self setNavigationBarHidden:YES];
        [self pushViewController:rootViewController animated:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UIViewController orientation & status bar override methods

- (void)setPreferredStatusBarStyle:(UIStatusBarStyle)preferredStatusBarStyle
{
    _preferredStatusBarStyle = preferredStatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return _preferredStatusBarStyle;
}

- (void)setSupportedInterfaceOrientations:(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    _supportedInterfaceOrientations = supportedInterfaceOrientations;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return _supportedInterfaceOrientations;
}

#pragma mark - UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count > 1;
}

#pragma mark - KUSObjectDataSourceListener methods

- (void)objectDataSourceDidLoad:(KUSObjectDataSource *)dataSource
{
    KUSUserSession *_userSession = [Kustomer sharedInstance].userSession;
    if (dataSource == _userSession.chatSettingsDataSource) {
        [_userSession.chatSettingsDataSource removeListener:self];
        
        KUSChatSettings *settings = [_userSession.chatSettingsDataSource object];
        [self setToolbarHidden:!settings.brandingKustomer];
    }
}

@end
