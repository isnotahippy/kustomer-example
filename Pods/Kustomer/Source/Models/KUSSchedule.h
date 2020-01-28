//
//  KUSBusinessHours.h
//  Kustomer
//
//  Created by Hunain Shahid on 15/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSModel.h"
#import "KUSHoliday.h"

@interface KUSSchedule : KUSModel

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSArray<NSArray<NSNumber *> *> *> *hours;
@property (nonatomic, copy, readonly) NSString *timezone;
@property (nonatomic, assign, readonly) BOOL enabled;

@property (nonatomic, copy, readonly) NSArray<KUSHoliday *> *holidays;

@end
