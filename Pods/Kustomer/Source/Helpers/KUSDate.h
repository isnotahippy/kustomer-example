//
//  KUSDate.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/20/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KUSDate : NSObject

+ (NSString *)humanReadableTextFromDate:(NSDate *)date;
+ (NSString *)volumeControlExpectedWaitTimeMessageForSeconds:(NSUInteger)seconds;
+ (NSString *)messageTimestampTextFromDate:(NSDate *)date;
+ (NSString *)volumeControlCurrentWaitTimeMessageForSeconds:(NSUInteger)seconds;

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;

@end
