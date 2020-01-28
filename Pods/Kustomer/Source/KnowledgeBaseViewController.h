//
//  KnowledgeBaseViewController.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/26/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <SafariServices/SafariServices.h>

@interface KnowledgeBaseViewController : SFSafariViewController

- (instancetype)init;

- (instancetype)initWithURL:(NSURL *)URL entersReaderIfAvailable:(BOOL)entersReaderIfAvailable NS_UNAVAILABLE;

@end
