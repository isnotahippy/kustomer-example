//
//  KUSModel.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KUSModel : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *oid;

// Relationships
@property (nonatomic, copy, readonly, nullable) NSString *orgId;
@property (nonatomic, copy, readonly, nullable) NSString *customerId;
@property (nonatomic, copy, readonly, nullable) NSString *sessionId;

+ (NSString * _Nullable)modelType;
+ (BOOL)enforcesModelType;

+ (NSArray<__kindof KUSModel *> *_Nullable)objectsWithJSON:(NSDictionary * _Nonnull)json;
+ (NSArray<__kindof KUSModel *> *_Nullable)objectsWithJSONs:(NSArray<NSDictionary *> * _Nullable)jsons;
- (instancetype _Nullable)initWithJSON:(NSDictionary * _Nonnull)json;
- (instancetype _Nonnull)init NS_UNAVAILABLE;
+ (instancetype _Nonnull)new NS_UNAVAILABLE;
- (NSDictionary *_Nonnull)originalJSON;
- (void)addIncludedWithJSON:(NSArray<NSDictionary *> *_Nullable)json;

NSURL *_Nullable NSURLFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath);
NSString *_Nullable NSStringFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath);
NSArray *_Nullable NSArrayFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath);
BOOL BOOLFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath);
NSInteger IntegerFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath);
double DoubleFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath);
NSDate * _Nullable DateFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath);

@end
