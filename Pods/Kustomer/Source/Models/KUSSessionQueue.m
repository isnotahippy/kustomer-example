//
//  KUSSessionQueue.m
//  Kustomer
//
//  Created by Hunain Shahid on 06/11/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSSessionQueue.h"

@implementation KUSSessionQueue

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"session_queue";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _enteredAt = DateFromKeyPath(json, @"attributes.enteredAt");
        _estimatedWaitTimeSeconds = DoubleFromKeyPath(json, @"attributes.estimatedWaitTimeSeconds");
        _latestWaitTimeSeconds = IntegerFromKeyPath(json, @"attributes.latestWaitTimeSeconds");
        _name = NSStringFromKeyPath(json, @"attributes.name");
    }
    return self;
}

@end
