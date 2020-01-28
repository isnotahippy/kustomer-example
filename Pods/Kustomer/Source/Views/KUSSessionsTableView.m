//
//  KUSSessionsTableView.m
//  Kustomer
//
//  Created by Daniel Amitay on 10/15/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSSessionsTableView.h"

#import "KUSColor.h"

@implementation KUSSessionsTableView

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSSessionsTableView class]) {
        KUSSessionsTableView *appearance = [self appearance];
        appearance.separatorInset = UIEdgeInsetsZero;
        appearance.separatorColor = [KUSColor grayColor];
    }
}

@end
