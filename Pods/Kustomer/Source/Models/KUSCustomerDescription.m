//
//  KUSCustomerDescription.m
//  Kustomer
//
//  Created by Daniel Amitay on 10/28/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSCustomerDescription.h"

@implementation KUSCustomerDescription

- (NSDictionary<NSString *, NSObject *> *_Nonnull)formData
{
    NSMutableDictionary<NSString *, NSObject *> *formData = [[NSMutableDictionary alloc] init];
    if (self.email) {
        formData[@"emails"] = @[ @{ @"email" : self.email } ];
    }
    if (self.phone) {
        formData[@"phones"] = @[ @{ @"phone" : self.phone } ];
    }

    NSMutableArray<NSDictionary<NSString *, NSString *> *> *socials = [[NSMutableArray alloc] init];
    if (self.twitter) {
        [socials addObject:@{ @"username" : self.twitter, @"type" : @"twitter" }];
    }
    if (self.facebook) {
        [socials addObject:@{ @"username" : self.facebook, @"type" : @"facebook" }];
    }
    if (self.instagram) {
        [socials addObject:@{ @"username" : self.instagram, @"type" : @"instagram" }];
    }
    if (self.linkedin) {
        [socials addObject:@{ @"username" : self.linkedin, @"type" : @"linkedin" }];
    }
    if (socials.count) {
        formData[@"socials"] = socials;
    }

    if (self.custom.count) {
        formData[@"custom"] = self.custom;
    }

    return formData;
}

@end
