//
//  KUSSatisfactionFormDataSource.h
//  Kustomer
//
//  Created by BrainX Technologies on 10/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSObjectDataSource.h"
#import "KUSSatisfactionResponse.h"

@interface KUSSatisfactionResponseDataSource : KUSObjectDataSource

- (instancetype)initWithUserSession:(KUSUserSession *)userSession AndSessionId:(NSString *)sessionId;
- (void)submitRating:(NSInteger)rating;
- (void)submitComment:(NSString *)comment;
- (BOOL)isSatisfactionEnabled;
- (KUSSatisfactionResponseStatus)satisfactionFormCurrentStatus;
@end
