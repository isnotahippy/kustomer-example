//
//  KUSCustomerDescription.h
//  Kustomer
//
//  Created by Daniel Amitay on 10/28/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KUSCustomerDescription : NSObject

@property (nonatomic, copy, nullable) NSString *email;
@property (nonatomic, copy, nullable) NSString *phone;

@property (nonatomic, copy, nullable) NSString *twitter;
@property (nonatomic, copy, nullable) NSString *facebook;
@property (nonatomic, copy, nullable) NSString *instagram;
@property (nonatomic, copy, nullable) NSString *linkedin;

@property (nonatomic, copy, nullable) NSDictionary<NSString *, NSObject *> *custom;

- (NSDictionary<NSString *, NSObject *> *_Nonnull)formData;

@end
