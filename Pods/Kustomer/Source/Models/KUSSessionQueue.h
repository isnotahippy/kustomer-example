//
//  KUSSessionQueue.h
//  Kustomer
//
//  Created by Hunain Shahid on 06/11/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSModel.h"

@interface KUSSessionQueue : KUSModel

@property (nonatomic, copy, readonly) NSDate *enteredAt;
@property (nonatomic, assign, readonly) NSTimeInterval estimatedWaitTimeSeconds;
@property (nonatomic, assign, readonly) NSUInteger latestWaitTimeSeconds;
@property (nonatomic, assign, readonly) NSString *name;

@end
