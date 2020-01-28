//
//  KUSMultipleAvatarsView.h
//  Kustomer
//
//  Created by Daniel Amitay on 1/1/18.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KUSUserSession;
@interface KUSMultipleAvatarsView : UIView

@property (nonatomic, assign) NSUInteger maximumAvatarsToDisplay UI_APPEARANCE_SELECTOR;

@property (nonatomic, copy) NSArray<NSString *> *userIds;

- (instancetype)initWithUserSession:(KUSUserSession *)userSession;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithImage:(UIImage *)image NS_UNAVAILABLE;

@end
