//
//  KUSMLNode.m
//  Kustomer
//
//  Created by BrainX Technologies on 01/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSMLNode.h"

@implementation KUSMLNode

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
        _nodeId = NSStringFromKeyPath(json, @"id");
        _deleted = BOOLFromKeyPath(json, @"deleted");
        
        // Filter deleted nodes
        NSArray<KUSMLNode *> *nodes = [KUSMLNode objectsWithJSONs:NSArrayFromKeyPath(json, @"children")];
        NSMutableArray<KUSMLNode *> *filteredNodes = [[NSMutableArray alloc] init];
        for (int i = 0; i < nodes.count; i++) {
            if (!nodes[i].deleted) {
                [filteredNodes addObject:nodes[i]];
            }
        }
        _nodeChilds = filteredNodes;
    }
    return self;
}

@end
