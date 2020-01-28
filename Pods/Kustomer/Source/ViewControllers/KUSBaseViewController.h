//
//  KUSBaseViewController.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/1/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KUSBaseViewController : UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

// Layout logic
- (UIEdgeInsets)edgeInsets;

// State helpers
- (void)showLoadingIndicatorWithText:(NSString *)text;
- (void)showLoadingIndicator;
- (void)hideLoadingIndicator;
- (void)showErrorWithText:(NSString *)text;

// Subclass overridable methods
- (void)userTappedRetryButton;

@end
