//
//  KUSNavigationBarView.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/16/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KUSNavigationBarView;
@protocol KUSNavigationBarViewDelegate <NSObject>

@optional
- (void)navigationBarViewDidTapBack:(KUSNavigationBarView *)navigationBarView;
- (void)navigationBarViewDidTapDismiss:(KUSNavigationBarView *)navigationBarView;

@end

@class KUSUserSession;
@interface KUSNavigationBarView : UIView

@property (nonatomic, strong) UIColor *nameColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *greetingColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *waitingColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIImage *backButtonImage UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIImage *dismissButtonImage UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *unreadColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *unreadBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *unreadFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, assign) BOOL showsLabels;
@property (nonatomic, assign) BOOL extraLarge;
@property (nonatomic, assign) CGFloat topInset;
@property (nonatomic, assign) BOOL showsBackButton;
@property (nonatomic, assign) BOOL showsDismissButton;

@property (nonatomic, weak) id<KUSNavigationBarViewDelegate> delegate;

- (instancetype)initWithUserSession:(KUSUserSession *)userSession;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (CGFloat)desiredHeight;

@end
