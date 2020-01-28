//
//  KUSForm.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/19/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSForm.h"

@implementation KUSForm

#pragma mark - Class methods

+ (NSString * _Nullable)modelType
{
    return @"form";
}

#pragma mark - Lifecycle methods

- (instancetype)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        _questions = [KUSFormQuestion objectsWithJSONs:NSArrayFromKeyPath(json, @"attributes.questions")];
    }
    return self;
}

#pragma mark - Helper methods

- (BOOL)containsEmailQuestion
{
    for (KUSFormQuestion *question in self.questions) {
        if (question.property == KUSFormQuestionPropertyCustomerEmail) {
            return YES;
        }
    }
    return NO;
}

@end
