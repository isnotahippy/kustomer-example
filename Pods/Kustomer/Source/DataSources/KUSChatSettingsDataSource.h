//
//  KUSChatSettingsDataSource.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/31/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSObjectDataSource.h"

#import "KUSChatSettings.h"

@interface KUSChatSettingsDataSource : KUSObjectDataSource

- (void)isChatAvailable:(void (^)(BOOL success, BOOL enabled))block;

@end
