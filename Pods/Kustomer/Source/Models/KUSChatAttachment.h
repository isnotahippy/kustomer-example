//
//  KUSChatAttachment.h
//  Kustomer
//
//  Created by Daniel Amitay on 12/10/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSModel.h"

@interface KUSChatAttachment : KUSModel

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSDate *updatedAt;

@end
