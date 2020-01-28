//
//  KUSChatTableView.m
//  Kustomer
//
//  Created by Daniel Amitay on 10/15/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSChatTableView.h"

@implementation KUSChatTableView

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSChatTableView class]) {
        KUSChatTableView *appearance = [self appearance];
        appearance.separatorInset = UIEdgeInsetsZero;
        appearance.separatorStyle = UITableViewCellSeparatorStyleNone;
        appearance.separatorColor = nil;
    }
}

@end
