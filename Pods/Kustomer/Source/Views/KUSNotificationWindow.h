//
//  KUSNotificationWindow.h
//  Kustomer
//
//  Created by Daniel Amitay on 9/18/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KUSChatSession;
@class KUSUserSession;
@interface KUSNotificationWindow : UIWindow

+ (KUSNotificationWindow *)sharedInstance;

- (void)showChatSession:(KUSChatSession *)chatSession autoDismiss:(BOOL)autoDismiss;
- (void)hide;

@end
