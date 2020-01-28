//
//  KUSHoliday.m
//  Kustomer
//
//  Created by Hunain Shahid on 15/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSHoliday.h"

@implementation KUSHoliday

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"holiday";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _name = NSStringFromKeyPath(json, @"attributes.name");
        _startDate = DateFromKeyPath(json, @"attributes.startDate");
        _endDate = DateFromKeyPath(json, @"attributes.endDate");
        _enabled = BOOLFromKeyPath(json, @"attributes.enabled");
    }
    return self;
}

@end
