//
//  KUSChatSessionTableViewCell.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/22/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat KUSChatSessionTableViewCellHeight;

@class KUSChatSession;
@class KUSUserSession;
@interface KUSChatSessionTableViewCell : UITableViewCell

@property (nonatomic, strong) UIColor *selectedBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *titleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *subtitleColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *subtitleFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *dateColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *dateFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *unreadColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *unreadBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *unreadFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *closedColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *closedFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *closedViewColor UI_APPEARANCE_SELECTOR;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier userSession:(KUSUserSession *)userSession;

- (void)setChatSession:(KUSChatSession *)chatSession;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
