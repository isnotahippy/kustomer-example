//
//  KUSTeam.h
//  Kustomer
//
//  Created by Daniel Amitay on 12/19/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSModel.h"

@interface KUSTeam : KUSModel

@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *icon;

- (NSString *)fullDisplay;

@end
