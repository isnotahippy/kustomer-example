//
//  KUSSatisfactionResponse.h
//  Kustomer
//
//  Created by BrainX Technologies on 11/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSModel.h"
#import "KUSSatisfactionForm.h"

typedef NS_ENUM(NSInteger, KUSSatisfactionResponseStatus) {
    KUSSatisfactionResponseStatusUnknown = -1,
    KUSSatisfactionResponseStatusOffered,
    KUSSatisfactionResponseStatusRated,
    KUSSatisfactionResponseStatusCommented
};

@interface KUSSatisfactionResponse : KUSModel

@property (nonatomic, copy, readonly) KUSSatisfactionForm *satisfactionForm;
@property (nonatomic, assign, readonly) KUSSatisfactionResponseStatus status;
@property (nonatomic, assign, readonly) NSInteger rating;
@property (nonatomic, copy, readonly) NSDate *lockedAt;
@property (nonatomic, copy, readonly) NSDate *updatedAt;
@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSDate *submittedAt;
@property (nonatomic, copy, readonly) NSMutableDictionary<NSString *, NSString *> *answers;

@end
