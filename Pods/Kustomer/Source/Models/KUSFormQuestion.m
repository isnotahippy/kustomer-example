//
//  KUSFormQuestion.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/19/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSFormQuestion.h"

@implementation KUSFormQuestion

#pragma mark - Class methods

+ (NSString * _Nullable)modelType
{
    return nil;
}

+ (BOOL)enforcesModelType
{
    return NO;
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _name = NSStringFromKeyPath(json, @"name");
        _prompt = NSStringFromKeyPath(json, @"prompt");
        _skipIfSatisfied = BOOLFromKeyPath(json, @"skipIfSatisfied");
        _type = KUSFormQuestionTypeFromString(NSStringFromKeyPath(json, @"type"));
        _property = KUSFormQuestionPropertyFromString(NSStringFromKeyPath(json, @"property"));
        if (_property == KUSFormQuestionPropertyMLV) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[json valueForKeyPath:@"valueMeta"]];
            [dic setObject:@"1" forKey:@"id"];
            _mlFormValues = [[KUSMLFormValue alloc] initWithJSON: dic];
        }
        NSArray<NSString *> *values = NSArrayFromKeyPath(json, @"values");
        if (values.count) {
            NSMutableArray<NSString *> *mappedValues = [[NSMutableArray alloc] initWithCapacity:values.count];
            for (NSString *value in values) {
                [mappedValues addObject:[[NSString alloc] initWithFormat:@"%@", value]];
            }
            _values =  mappedValues;
        }
    }
    return self;
}

static KUSFormQuestionType KUSFormQuestionTypeFromString(NSString *string)
{
    if ([string isEqualToString:@"message"]) {
        return KUSFormQuestionTypeMessage;
    } else if ([string isEqualToString:@"property"]) {
        return KUSFormQuestionTypeProperty;
    } else if ([string isEqualToString:@"response"]) {
        return KUSFormQuestionTypeResponse;
    }
    return KUSFormQuestionTypeUnknown;
}

static KUSFormQuestionProperty KUSFormQuestionPropertyFromString(NSString *string)
{
    if ([string isEqualToString:@"customer_name"]) {
        return KUSFormQuestionPropertyCustomerName;
    } else if ([string isEqualToString:@"customer_email"]) {
        return KUSFormQuestionPropertyCustomerEmail;
    } else if ([string isEqualToString:@"conversation_team"]) {
        return KUSFormQuestionPropertyConversationTeam;
    } else if ([string isEqualToString:@"customer_phone"]) {
        return KUSFormQuestionPropertyCustomerPhone;
    } else if ([string isEqualToString:@"followup_channel"]) {
        return KUSFormQuestionPropertyFollowupChannel;
    } else if ([string hasSuffix:@"Tree"]) {
        return KUSFormQuestionPropertyMLV;
    } else if ([string hasSuffix:@"Str"] || [string hasSuffix:@"Num"]) {
        return KUSFormQuestionPropertyValues;
    }
    return KUSFormQuestionPropertyUnknown;
}

@end
