//
//  KUSNavigationController.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KUSNavigationController : UINavigationController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass NS_UNAVAILABLE;

// Custom setter if you want a specific status bar style (e.g. if you have customized the appearance)
- (void)setPreferredStatusBarStyle:(UIStatusBarStyle)preferredStatusBarStyle;

// Custom setter if you want to disable any interface orientations
- (void)setSupportedInterfaceOrientations:(UIInterfaceOrientationMask)supportedInterfaceOrientations;

@end
