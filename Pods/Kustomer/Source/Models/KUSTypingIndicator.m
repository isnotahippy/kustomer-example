//
//  KUSTypingIndicator.m
//  Kustomer
//
//  Created by Hunain Shahid on 17/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSTypingIndicator.h"

@implementation KUSTypingIndicator

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"conversation";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _userId = NSStringFromKeyPath(json, @"userId");
        _typingStatus = KUSTypingStatusFromString(NSStringFromKeyPath(json, @"status"));
    }
    return self;
}

#pragma mark - NSObject methods

- (BOOL)isEqual:(id)object
{
    if (object == self) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    KUSTypingIndicator *typingIndicator = (KUSTypingIndicator *)object;
    
    if (![typingIndicator.userId isEqual:self.userId]) {
        return NO;
    }
    if (typingIndicator.typingStatus != self.typingStatus) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Convenience methods

KUSTypingStatus KUSTypingStatusFromString(NSString *string)
{
    if ([string isEqualToString:@"typing"]) {
        return KUSTyping;
    } else if ([string isEqualToString:@"typing-ended"]) {
        return KUSTypingEnded;
    }
    return KUSTypingUnknown;
}

@end
