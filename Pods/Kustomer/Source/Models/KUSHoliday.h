//
//  KUSHoliday.h
//  Kustomer
//
//  Created by Hunain Shahid on 15/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSModel.h"

@interface KUSHoliday : KUSModel

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSDate *startDate;
@property (nonatomic, copy, readonly) NSDate *endDate;
@property (nonatomic, assign, readonly) BOOL enabled;

@end
