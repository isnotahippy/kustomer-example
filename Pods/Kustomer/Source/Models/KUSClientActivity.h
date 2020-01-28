//
//  KUSClientActivity.h
//  Kustomer
//
//  Created by Daniel Amitay on 2/10/18.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSModel.h"

@interface KUSClientActivity : KUSModel

@property (nonatomic, copy, readonly) NSArray<NSNumber *> *intervals;

@property (nonatomic, copy, readonly) NSString *currentPage;
@property (nonatomic, copy, readonly) NSString *previousPage;
@property (nonatomic, assign, readonly) NSTimeInterval currentPageSeconds;
@property (nonatomic, copy, readonly) NSDate *createdAt;

@end
