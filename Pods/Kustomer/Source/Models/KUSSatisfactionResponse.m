//
//  KUSSatisfactionResponse.m
//  Kustomer
//
//  Created by BrainX Technologies on 11/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSSatisfactionResponse.h"

@implementation KUSSatisfactionResponse

#pragma mark - Class methods

+ (NSString * _Nullable)modelType
{
    return @"satisfaction_response";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _status = KUSSatisfactionResponseStatusFromString(NSStringFromKeyPath(json, @"attributes.status"));
        _lockedAt = DateFromKeyPath(json, @"attributes.lockedAt");
        _updatedAt = DateFromKeyPath(json, @"attributes.updatedAt");
        _createdAt = DateFromKeyPath(json, @"attributes.createdAt");
        _submittedAt = DateFromKeyPath(json, @"attributes.submittedAt");
        _rating = IntegerFromKeyPath(json, @"attributes.rating");
        NSArray *answers = NSArrayFromKeyPath(json, @"attributes.answers");
        _answers = [[NSMutableDictionary alloc] init];
        for (int i=0; i<answers.count; i++) {
            [_answers setValue:NSStringFromKeyPath(answers[i],@"answer")  forKey:NSStringFromKeyPath(answers[i],@"id")];
        }
    }
    return self;
}

- (void)addIncludedWithJSON:(NSArray<NSDictionary *> *)json
{
    [super addIncludedWithJSON:json];
    _satisfactionForm = [[KUSSatisfactionForm alloc] initWithJSON:json.firstObject];
}

- (void)updateResponseData:(NSDictionary *)json
{
    _status = KUSSatisfactionResponseStatusFromString(NSStringFromKeyPath(json, @"status"));
    _submittedAt = DateFromKeyPath(json, @"submittedAt");
    _rating = IntegerFromKeyPath(json, @"rating");
    NSArray *answers = NSArrayFromKeyPath(json, @"answers");
    for (int i=0; i<answers.count; i++) {
        [_answers setValue:NSStringFromKeyPath(answers[i],@"answer")  forKey:NSStringFromKeyPath(answers[i],@"id")];
    }
}

static KUSSatisfactionResponseStatus KUSSatisfactionResponseStatusFromString(NSString *string)
{
    if ([string isEqualToString:@"offered"]) {
        return KUSSatisfactionResponseStatusOffered;
    } else if ([string isEqualToString:@"rated"]) {
        return KUSSatisfactionResponseStatusRated;
    } else if ([string isEqualToString:@"commented"]) {
        return KUSSatisfactionResponseStatusCommented;
    }
    return KUSSatisfactionResponseStatusUnknown;
}

@end
