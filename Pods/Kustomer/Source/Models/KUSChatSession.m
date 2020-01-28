//
//  KUSChatSession.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSChatSession.h"

#import "KUSChatMessage.h"
#import "KUSDate.h"

@implementation KUSChatSession

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"chat_session";
}

+ (KUSChatSession *)tempSessionFromChatMessage:(KUSChatMessage *)message
{
    NSDictionary *json = @{
        @"id": message.sessionId ?: @"",
        @"type": [self modelType],
        @"attributes": @{
            @"preview": message.body ?: @"",
            @"createdAt": [KUSDate stringFromDate:message.createdAt ?: [NSDate date]] ,
            @"lastSeenAt": [KUSDate stringFromDate:message.createdAt ?: [NSDate date]],
            @"lastMessageAt": [KUSDate stringFromDate:message.createdAt ?: [NSDate date]],
        }
    };
    return [[KUSChatSession alloc] initWithJSON:json];
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _preview = NSStringFromKeyPath(json, @"attributes.preview");
        _trackingId = NSStringFromKeyPath(json, @"attributes.trackingId");

        _createdAt = DateFromKeyPath(json, @"attributes.createdAt");
        _lastSeenAt = DateFromKeyPath(json, @"attributes.lastSeenAt");
        _lastMessageAt = DateFromKeyPath(json, @"attributes.lastMessageAt");
        _lockedAt = DateFromKeyPath(json, @"attributes.lockedAt");
        
        _satisfactionId = NSStringFromKeyPath(json, @"attributes.satisfaction.id");
        _satisfactionStatus = NSStringFromKeyPath(json, @"attributes.satisfaction.status");
        _satisfactionLockedAt = DateFromKeyPath(json, @"attributes.satisfaction.lockedAt");
    }
    return self;
}

#pragma mark - NSObject methods

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: oid: %@; preview: %@>",
            NSStringFromClass([self class]), self, self.oid, self.preview];
}

- (BOOL)isEqual:(id)object
{
    if (object == self) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    KUSChatSession *chatSession = (KUSChatSession *)object;

    if (![chatSession.oid isEqual:self.oid]) {
        return NO;
    }
    if ((chatSession.preview || self.preview) && ![chatSession.preview isEqual:self.preview]) {
        return NO;
    }
    if (![chatSession.lastSeenAt isEqual:self.lastSeenAt]) {
        return NO;
    }
    if (![chatSession.lastMessageAt isEqual:self.lastMessageAt]) {
        return NO;
    }
    if (![chatSession.createdAt isEqual:self.createdAt]) {
        return NO;
    }

    return YES;
}

@end
