//
//  KUSMLFormValue.m
//  Kustomer
//
//  Created by BrainX Technologies on 01/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSMLFormValue.h"

@implementation KUSMLFormValue

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
        _displayName = NSStringFromKeyPath(json, @"displayName");
        _lastNodeRequired = BOOLFromKeyPath(json, @"lastNodeRequired");
        
        // Filter deleted nodes
        NSArray<KUSMLNode *> *nodes = [KUSMLNode objectsWithJSONs:NSArrayFromKeyPath(json, @"tree.children")];
        NSMutableArray<KUSMLNode *> *filteredNodes = [[NSMutableArray alloc] init];
        for (int i = 0; i < nodes.count; i++) {
            if (!nodes[i].deleted) {
                [filteredNodes addObject:nodes[i]];
            }
        }
        _mlNodes = filteredNodes;
    }
    return self;
}

@end
