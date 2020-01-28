//
//  KUSNewSessionButton.h
//  Kustomer
//
//  Created by Daniel Amitay on 9/5/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KUSUserSession;
@interface KUSNewSessionButton : UIButton

@property (nonatomic, strong) UIColor *color UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIImage *image UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSString *text UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL hasShadow UI_APPEARANCE_SELECTOR;

- (instancetype)initWithUserSession:(KUSUserSession *)userSession;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (BOOL)isBackToChat;
- (void)updateButton;

@end
