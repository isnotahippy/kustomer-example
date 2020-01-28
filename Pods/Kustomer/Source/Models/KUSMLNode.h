//
//  KUSMLNode.h
//  Kustomer
//
//  Created by BrainX Technologies on 01/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSModel.h"

@interface KUSMLNode : KUSModel

@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *nodeId;
@property (nonatomic, assign, readonly) BOOL deleted;
@property (nonatomic, copy, nullable) NSArray<KUSMLNode *> *nodeChilds;

@end
