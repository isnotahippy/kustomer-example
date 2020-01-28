//
//  KUSUser.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/18/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSModel.h"

@interface KUSUser : KUSModel

@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSURL *avatarURL;

@end
