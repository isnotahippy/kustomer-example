//
//  KUSChatAttachment.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/10/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSChatAttachment.h"

@implementation KUSChatAttachment

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"attachment";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _name = NSStringFromKeyPath(json, @"attributes.name");

        _createdAt = DateFromKeyPath(json, @"attributes.createdAt");
        _updatedAt = DateFromKeyPath(json, @"attributes.updatedAt");
    }
    return self;
}

@end
