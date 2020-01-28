//
//  KUSClientActivity.m
//  Kustomer
//
//  Created by Daniel Amitay on 2/10/18.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSClientActivity.h"

@implementation KUSClientActivity

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"client_activity";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _intervals = [json valueForKeyPath:@"attributes.intervals.@unionOfObjects.seconds"];

        _currentPage = NSStringFromKeyPath(json, @"attributes.currentPage");
        _previousPage = NSStringFromKeyPath(json, @"attributes.previousPage");
        _currentPageSeconds = DoubleFromKeyPath(json, @"attributes.currentPageSeconds");
        _createdAt = DateFromKeyPath(json, @"attributes.createdAt");
    }
    return self;
}

@end
