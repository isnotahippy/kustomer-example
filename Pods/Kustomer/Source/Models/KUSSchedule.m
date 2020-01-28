//
//  KUSBusinessHours.m
//  Kustomer
//
//  Created by Hunain Shahid on 15/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSSchedule.h"

@implementation KUSSchedule

#pragma mark - Class methods

+ (NSString *)modelType
{
    return @"schedule";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _name = NSStringFromKeyPath(json, @"attributes.name");
        _hours = [json valueForKeyPath:@"attributes.hours"];
        _timezone = NSStringFromKeyPath(json, @"attributes.timezone");
        _enabled = BOOLFromKeyPath(json, @"attributes.default");
    }
    return self;
}

- (void)addIncludedWithJSON:(NSArray<NSDictionary *> *)json
{
    [super addIncludedWithJSON:json];
    _holidays = [KUSHoliday objectsWithJSONs:json];
}

@end
