//
//  KUSPaginatedResponse.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/4/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSPaginatedResponse.h"

#import "KUSModel.h"

@implementation KUSPaginatedResponse

#pragma mark - Lifecycle methods

- (instancetype _Nullable)initWithJSON:(NSDictionary * _Nonnull)json modelClass:(Class _Nonnull)modelClass
{
    // Debug-only assert that modelClass is a subclass of KUSModel
    NSAssert([modelClass isSubclassOfClass:[KUSModel class]], @"modelClass must be a subclass of KUSModel!");

    // There needs to be json to parse
    if (![json isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    // The data needs to be an array or dictionary
    id data = json[@"data"];
    BOOL dataIsArray = [data isKindOfClass:[NSArray class]];
    BOOL dataIsDictionary = [data isKindOfClass:[NSDictionary class]];
    if (!dataIsArray && !dataIsDictionary) {
        return nil;
    }

    // Actually create the object
    self = [super init];
    if (self) {
        NSMutableArray<__kindof KUSModel *> *objects = [[NSMutableArray alloc] init];
        if (dataIsArray) {
            NSArray<NSDictionary *> *jsonObjects = json[@"data"];
            for (NSDictionary *jsonObject in jsonObjects) {
                NSArray<__kindof KUSModel *> *models = [modelClass objectsWithJSON:jsonObject];
                for (__kindof KUSModel *model in [models reverseObjectEnumerator]) {
                    [objects addObject:model];
                }
            }
            _objects = objects;
        } else if (dataIsDictionary) {
            NSArray<__kindof KUSModel *> *models = [modelClass objectsWithJSON:data];
            for (__kindof KUSModel *model in [models reverseObjectEnumerator]) {
                [objects addObject:model];
            }
        }
        _objects = objects;

        _page = IntegerFromKeyPath(json, @"meta.page");
        _pageSize = MAX(IntegerFromKeyPath(json, @"meta.pageSize"), _objects.count);

        _selfPath = NSStringFromKeyPath(json, @"links.self");
        _firstPath = NSStringFromKeyPath(json, @"links.first");
        _prevPath = NSStringFromKeyPath(json, @"links.prev");
        _nextPath = NSStringFromKeyPath(json, @"links.next");
    }
    return self;
}

@end
