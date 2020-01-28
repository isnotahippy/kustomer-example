//
//  KUSChatPlaceholderTableViewCell.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/22/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KUSChatPlaceholderTableViewCell : UITableViewCell

@property (nonatomic, strong) UIColor *lineColor UI_APPEARANCE_SELECTOR;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
