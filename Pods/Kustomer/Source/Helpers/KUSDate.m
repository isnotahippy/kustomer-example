//
//  KUSDate.m
//  Kustomer
//
//  Created by Daniel Amitay on 8/20/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSDate.h"
#import "Kustomer_Private.h"
#import "KUSUserSession.h"
#import "KUSLocalization.h"

const NSTimeInterval kSecondsPerMinute = 60.0;
const NSTimeInterval kMinutesPerHour = 60.0;
const NSTimeInterval kHoursPerDay = 24.0;
const NSTimeInterval kDaysPerWeek = 7.0;

@implementation KUSDate

+ (NSString *)humanReadableTextFromDate:(NSDate *)date
{
    if (date == nil) {
        return nil;
    }
    
    NSTimeInterval timeAgo = -[date timeIntervalSinceNow];
    if (timeAgo >= kSecondsPerMinute * kMinutesPerHour * kHoursPerDay * kDaysPerWeek) {
        NSTimeInterval count = timeAgo / (kSecondsPerMinute * kMinutesPerHour * kHoursPerDay * kDaysPerWeek);
        return _AgoTextWithCountAndUnit(count, @"week");
    } else if (timeAgo >= kSecondsPerMinute * kMinutesPerHour * kHoursPerDay) {
        NSTimeInterval count = timeAgo / (kSecondsPerMinute * kMinutesPerHour * kHoursPerDay);
        return _AgoTextWithCountAndUnit(count, @"day");
    } else if (timeAgo >= kSecondsPerMinute * kMinutesPerHour) {
        NSTimeInterval count = timeAgo / (kSecondsPerMinute * kMinutesPerHour);
        return _AgoTextWithCountAndUnit(count, @"hour");
    } else if (timeAgo >= kSecondsPerMinute) {
        NSTimeInterval count = timeAgo / (kSecondsPerMinute);
        return _AgoTextWithCountAndUnit(count, @"minute");
    } else {
        return [[KUSLocalization sharedInstance] localizedString:@"Just now"];
    }
}

+ (NSString *)volumeControlCurrentWaitTimeMessageForSeconds:(NSUInteger)seconds
{
    NSString *localizedMessage;
    int time;
    if (seconds < kSecondsPerMinute) {
        time = (int)seconds;
        NSString *localizedKey = _ourWaitTimeWithUnit(time, @"second");
        localizedMessage = [[KUSLocalization sharedInstance] localizedString:localizedKey];
    } else if (seconds < kSecondsPerMinute * kMinutesPerHour) {
        time = (int)ceil(seconds / kSecondsPerMinute);
        NSString *localizedKey = _ourWaitTimeWithUnit(time, @"minute");
        localizedMessage = [[KUSLocalization sharedInstance] localizedString:localizedKey];
    } else if (seconds < kSecondsPerMinute * kMinutesPerHour * kHoursPerDay) {
        time = (int)ceil(seconds / (kSecondsPerMinute * kMinutesPerHour));
        NSString *localizedKey = _ourWaitTimeWithUnit(time, @"hour");
        localizedMessage = [[KUSLocalization sharedInstance] localizedString:localizedKey];
    } else {
        return localizedMessage = [[KUSLocalization sharedInstance] localizedString:@"our_expected_wait_time_is_approximately_greater_than_one_day"];
    }
    
    NSString *timeString = [[NSString alloc] initWithFormat:@"%i", time];
    return [[NSString alloc] initWithFormat:localizedMessage, timeString];
}

+ (NSString *)volumeControlExpectedWaitTimeMessageForSeconds:(NSUInteger)seconds
{
    if (seconds == 0) {
        return [[KUSLocalization sharedInstance] localizedString:@"Someone should be with you momentarily"];
    } else {
        NSString *localizedMessage;
        int time;
        if (seconds < kSecondsPerMinute) {
            time = (int)seconds;
            NSString *localizedKey = _yourExpectedWaitTimeWithUnit(time, @"second");
            localizedMessage = [[KUSLocalization sharedInstance] localizedString:localizedKey];
        } else if (seconds < kSecondsPerMinute * kMinutesPerHour) {
            time = (int)ceil(seconds / kSecondsPerMinute);
            NSString *localizedKey = _yourExpectedWaitTimeWithUnit(time, @"minute");
            localizedMessage = [[KUSLocalization sharedInstance] localizedString:localizedKey];
        } else if (seconds < kSecondsPerMinute * kMinutesPerHour * kHoursPerDay) {
            time = (int)ceil(seconds / (kSecondsPerMinute * kMinutesPerHour));
            NSString *localizedKey = _yourExpectedWaitTimeWithUnit(time, @"hour");
            localizedMessage = [[KUSLocalization sharedInstance] localizedString:localizedKey];
        } else {
            return localizedMessage = [[KUSLocalization sharedInstance] localizedString:@"your_expected_wait_time_is_greater_than_one_day"];
        }
        NSString *timeString = [[NSString alloc] initWithFormat:@"%i", time];
        return [[NSString alloc] initWithFormat:localizedMessage, timeString];
    }
}

+ (NSString *)messageTimestampTextFromDate:(NSDate *)date
{
    return [_ShortRelativeDateFormatter() stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)string
{
    return (string.length ? [_ISO8601DateFormatterFromString() dateFromString:string] : nil);
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    return (date ? [_ISO8601DateFormatterFromDate() stringFromDate:date] : nil);
}

#pragma mark - Helper logic

static NSString *_ourWaitTimeWithUnit(NSTimeInterval unitCount, NSString *unit)
{
    NSString *localizedMessage = @"our_expected_wait_time_is_approximately_param_";
    int integerUnit = (int)round(unitCount);
    return [[NSString alloc] initWithFormat:@"%@%@%@", localizedMessage, unit, integerUnit > 1 ? @"s": @""];
}


static NSString *_yourExpectedWaitTimeWithUnit(NSTimeInterval unitCount, NSString *unit)
{
    NSString *localizedMessage = @"your_expected_wait_time_is_param_";
    int integerUnit = (int)round(unitCount);
    return [[NSString alloc] initWithFormat:@"%@%@%@", localizedMessage, unit, integerUnit > 1 ? @"s": @""];
}

static NSDateFormatter *_ShortRelativeDateFormatter(void)
{
    static NSDateFormatter *_dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.timeStyle = NSDateFormatterShortStyle;
        _dateFormatter.dateStyle = NSDateFormatterShortStyle;
        _dateFormatter.locale = [[KUSLocalization sharedInstance] currentLocale];
        _dateFormatter.doesRelativeDateFormatting = YES;
    });
    return _dateFormatter;
}

static NSString *_AgoTextWithCountAndUnit(NSTimeInterval unitCount, NSString *unit)
{
    int integerUnitCount = (int)round(unitCount);
    NSString *unitString = [NSString stringWithFormat:@"%@%@", unit, (integerUnitCount > 1 ? @"s": @"")];
    NSString* localizedKey = [NSString stringWithFormat:@"param_%@_ago", unitString];
    NSString *localizedString = [[KUSLocalization sharedInstance] localizedString:localizedKey];
    NSString *unitCountString = [NSString stringWithFormat:@"%i", integerUnitCount];
    return [NSString stringWithFormat:localizedString,unitCountString];
}

static NSDateFormatter *_ISO8601DateFormatterFromDate(void)
{
    static NSDateFormatter *_dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    return _dateFormatter;
}

static NSDateFormatter *_ISO8601DateFormatterFromString(void)
{
    static NSDateFormatter *_dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        [_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    });
    return _dateFormatter;
}

@end
