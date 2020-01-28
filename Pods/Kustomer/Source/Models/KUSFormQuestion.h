//
//  KUSFormQuestion.h
//  Kustomer
//
//  Created by Daniel Amitay on 12/19/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSModel.h"
#import "KUSMLFormValue.h"

typedef NS_ENUM(NSInteger, KUSFormQuestionType) {
    KUSFormQuestionTypeUnknown = -1,
    KUSFormQuestionTypeMessage,
    KUSFormQuestionTypeProperty,
    KUSFormQuestionTypeResponse,
};

typedef NS_ENUM(NSInteger, KUSFormQuestionProperty) {
    KUSFormQuestionPropertyUnknown = -1,
    KUSFormQuestionPropertyCustomerName,
    KUSFormQuestionPropertyCustomerEmail,
    KUSFormQuestionPropertyConversationTeam,
    KUSFormQuestionPropertyCustomerPhone,
    KUSFormQuestionPropertyFollowupChannel,
    KUSFormQuestionPropertyMLV,
    KUSFormQuestionPropertyValues
};

@interface KUSFormQuestion : KUSModel

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *prompt;
@property (nonatomic, copy, readonly) NSArray<NSString *> *values;
@property (nonatomic, assign, readonly) KUSFormQuestionType type;
@property (nonatomic, assign, readonly) KUSFormQuestionProperty property;
@property (nonatomic, assign, readonly) BOOL skipIfSatisfied;
@property (nonatomic, copy, readonly) KUSMLFormValue *mlFormValues;

@end

static inline BOOL KUSFormQuestionRequiresResponse(KUSFormQuestion *question)
{
    return question.type == KUSFormQuestionTypeProperty || question.type == KUSFormQuestionTypeResponse;
}

