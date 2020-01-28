//
//  KUSTeam.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/19/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSTeam.h"

@implementation KUSTeam {
    NSString *_emoji;
}

#pragma mark - Class methods

+ (NSString * _Nullable)modelType
{
    return nil;
}

+ (BOOL)enforcesModelType
{
    return NO;
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _displayName = NSStringFromKeyPath(json, @"attributes.displayName");
        _icon = NSStringFromKeyPath(json, @"attributes.icon");

        @try {
            unsigned emojiInt = 0;
            if ([[NSScanner scannerWithString:_icon] scanHexInt:&emojiInt]) {
                _emoji = [[NSString alloc] initWithBytes:&emojiInt length:4 encoding:NSUTF32LittleEndianStringEncoding];
            }
        }
        @catch (NSException *exception) {}
    }
    return self;
}

- (NSString *)fullDisplay
{
    if (_emoji) {
        return [NSString stringWithFormat:@"%@ %@", _emoji, self.displayName];
    }
    return self.displayName;
}

@end
