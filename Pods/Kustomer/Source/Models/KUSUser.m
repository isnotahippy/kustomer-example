//
//  KUSUser.m
//  Kustomer
//
//  Created by Daniel Amitay on 8/18/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSUser.h"

@implementation KUSUser

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"user";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _displayName = NSStringFromKeyPath(json, @"attributes.displayName");
        _avatarURL = NSURLFromKeyPath(json, @"attributes.avatarUrl");
    }
    return self;
}

@end
