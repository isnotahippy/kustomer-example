//
//  KUSModel.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSModel.h"

#import "KUSDate.h"

@implementation KUSModel {
    NSDictionary *_rawJSON;
}

#pragma mark - Class methods

+ (NSString * _Nullable)modelType
{
    return nil;
}

+ (BOOL)enforcesModelType
{
    return YES;
}

#pragma mark - Lifecycle methods

+ (NSArray<__kindof KUSModel *> *_Nullable)objectsWithJSON:(NSDictionary * _Nonnull)json
{
    KUSModel *model = [[self alloc] initWithJSON:json];
    return (model ? @[ model ] : nil);
}

+ (NSArray<__kindof KUSModel *> *_Nullable)objectsWithJSONs:(NSArray<NSDictionary *> * _Nullable)jsons
{
    NSMutableArray<__kindof KUSModel *> *objects = [[NSMutableArray alloc] initWithCapacity:jsons.count];
    for (NSDictionary *json in jsons) {
        KUSModel *object = [[self alloc] initWithJSON:json];
        if (object) {
            [objects addObject:object];
        }
    }
    return objects;
}

- (instancetype _Nullable)initWithJSON:(NSDictionary * _Nonnull)json
{
    // Reject non-dictionary objects
    if (![json isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    // Reject any objects where the model type doesn't match, if enforced
    NSString *type = json[@"type"];
    NSString *classType = [[self class] modelType];
    if ([[self class] enforcesModelType] && ![type isEqual:classType]) {
        return nil;
    }

    // Make sure there is an object id
    NSString *objectId = json[@"id"];
    if (objectId == nil) {
        return nil;
    }

    // Actually create the object
    self = [super init];
    if (self) {
        _oid = objectId;
        _rawJSON = [json copy];

        // Grab relationship identifiers
        _orgId = NSStringFromKeyPath(json, @"relationships.org.data.id");
        _customerId = NSStringFromKeyPath(json, @"relationships.customer.data.id");
        _sessionId = NSStringFromKeyPath(json, @"relationships.session.data.id");
    }
    return self;
}

#pragma mark - NSObject methods

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ %p: oid: %@>",
            NSStringFromClass([self class]), self, self.oid];
}

- (NSUInteger)hash
{
    return [self.oid hash];
}

- (NSDictionary *_Nonnull)originalJSON
{
    return _rawJSON;
}

#pragma mark - sub class methods

- (void)addIncludedWithJSON:(NSArray<NSDictionary *> *_Nullable)json { }

#pragma mark - Helper methods

NSURL *_Nullable NSURLFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath)
{
    NSString *value = NSStringFromKeyPath(dict, keyPath);
    return value ? [NSURL URLWithString:value] : nil;
}

NSString *_Nullable NSStringFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath)
{
    NSString *value = [dict valueForKeyPath:keyPath];
    return ([value isKindOfClass:[NSString class]] ? value : nil);
}

NSArray *_Nullable NSArrayFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath)
{
    NSArray *value = [dict valueForKeyPath:keyPath];
    return ([value isKindOfClass:[NSArray class]] ? value : nil);
}

BOOL BOOLFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath)
{
    id value = [dict valueForKeyPath:keyPath];
    if ([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    return NO;
}

NSInteger IntegerFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath)
{
    id value = [dict valueForKeyPath:keyPath];
    if ([value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    return 0;
}

double DoubleFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath)
{
    id value = [dict valueForKeyPath:keyPath];
    if ([value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    return 0.0;
}

NSDate *DateFromKeyPath(NSDictionary * _Nullable dict, NSString * _Nonnull keyPath)
{
    NSString *value = NSStringFromKeyPath(dict, keyPath);
    return (value ? [KUSDate dateFromString:value] : nil);
}

@end
