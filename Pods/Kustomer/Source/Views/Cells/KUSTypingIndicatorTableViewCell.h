//
//  KUSTypingIndicatorTableViewCell.h
//  Kustomer
//
//  Created by Hunain Shahid on 17/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUSUserSession.h"
#import "KUSTypingIndicator.h"

@interface KUSTypingIndicatorTableViewCell : UITableViewCell

@property (nonatomic, strong) UIColor *typingIndicatorColor UI_APPEARANCE_SELECTOR;

+ (CGFloat)heightForBubble;

- (void)setTypingIndicator:(KUSTypingIndicator *)typingIndicator;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier userSession:(KUSUserSession *)userSession;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
