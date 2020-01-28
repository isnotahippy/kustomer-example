//
//  KUSSatisfactionResponseDataSource.m
//  Kustomer
//
//  Created by BrainX Technologies on 11/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSSatisfactionResponseDataSource.h"
#import "KUSSatisfactionResponse_Private.h"
#import "KUSObjectDataSource_Private.h"
#import "KUSDate.h"

@interface KUSSatisfactionResponseDataSource () <KUSObjectDataSourceListener> {
    NSString *_sessionId;
    BOOL _isEnabled;
}
@end

@implementation KUSSatisfactionResponseDataSource

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession AndSessionId:(NSString *)sessionId
{
    self = [super initWithUserSession:userSession];
    if (self) {
        _sessionId = sessionId;
        _isEnabled = YES;
    }
    return self;
}

#pragma mark - KUSObjectDataSource subclass methods

- (void)performRequestWithCompletion:(KUSRequestCompletion)completion
{
    NSString *endpoint = [NSString stringWithFormat:@"/c/v1/chat/sessions/%@/satisfaction", _sessionId];
    NSURL *URL = [self.userSession.requestManager URLForEndpoint:endpoint];
    
    [self.userSession.requestManager performRequestType:KUSRequestTypePost
                                                    URL:URL
                                                 params:nil
                                          authenticated:YES
                                      additionalHeaders:[self _additionalHeaders]
                                             completion:^(NSError *error, NSDictionary *response) {
                                                 // Check if the response is empty
                                                 if (error.code == 3840) {
                                                     _isEnabled = NO;
                                                 }
                                                 completion(error, response);
                                             }];
}

- (Class)modelClass
{
    return [KUSSatisfactionResponse class];
}

#pragma mark - Internal Methods

- (nullable NSDictionary *)_additionalHeaders
{
    return @{ @"Content-Type": @"application/json" };
}

- (void)submitSatisfactionResponseWithRating:(NSInteger)rating AndComment:(NSString *)comment
{
    NSString *endpoint = [NSString stringWithFormat:@"/c/v1/chat/satisfaction-responses/%@", self.object.oid];
    NSURL *URL = [self.userSession.requestManager URLForEndpoint:endpoint];
    KUSSatisfactionResponse *satisfactionResponse = (KUSSatisfactionResponse *)self.object;
    NSString *answerId = satisfactionResponse.satisfactionForm.questions.firstObject.oid;
    NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
    
    if (rating > 0) {
        NSDictionary *ratingResponse = @{
          @"rating" : [NSNumber numberWithInteger:rating]
        };
        [response addEntriesFromDictionary:ratingResponse];
    }
    if (comment != nil) {
        NSDictionary *commentResponse = @{
          @"answers": @[
            @{
                @"id": answerId,
                @"answer": comment
            }]
        };
        [response addEntriesFromDictionary:commentResponse];
    }
    
    BOOL formHasQuestions = satisfactionResponse.satisfactionForm.questions.count > 0;
    BOOL shouldAddSubmittedAt = (formHasQuestions && comment != nil) || !formHasQuestions;
    
    if (shouldAddSubmittedAt) {
        NSDictionary *submittedAtResponse = @{
          @"submittedAt": [KUSDate stringFromDate:[NSDate date]]
        };
        [response addEntriesFromDictionary:submittedAtResponse];
    }
    
    
    [self.userSession.requestManager performRequestType:KUSRequestTypePut
                                                    URL:URL
                                                 params:response
                                          authenticated:YES
                                             completion:nil];
    
    NSMutableDictionary *updatedResponse = [[NSMutableDictionary alloc] initWithDictionary:response];
    NSString *status = comment != nil ? @"commented" : @"rated";
    [updatedResponse setObject:status forKey:@"status"];
    
    [self.object updateResponseData:updatedResponse];
}

#pragma mark - Public methods

- (void)submitRating:(NSInteger)rating
{
    [self submitSatisfactionResponseWithRating:rating AndComment:nil];
}

- (void)submitComment:(NSString *)comment
{
    [self submitSatisfactionResponseWithRating:0 AndComment:comment];
}

- (KUSSatisfactionResponseStatus)satisfactionFormCurrentStatus
{
    KUSSatisfactionResponse *satisfactionResponse = (KUSSatisfactionResponse *)self.object;
    BOOL isSatisfactionOffered = satisfactionResponse.status == KUSSatisfactionResponseStatusOffered;
    BOOL isSatisfactionRated = satisfactionResponse.status == KUSSatisfactionResponseStatusRated;
    BOOL isSatisfactionFormHasQuestions = satisfactionResponse.satisfactionForm.questions.count > 0;
    if (isSatisfactionOffered) {
        return KUSSatisfactionResponseStatusOffered;
    } else if (isSatisfactionRated && isSatisfactionFormHasQuestions) {
        return KUSSatisfactionResponseStatusRated;
    }
    return KUSSatisfactionResponseStatusCommented;
}

- (BOOL)isSatisfactionEnabled
{
    return _isEnabled;
}
@end
