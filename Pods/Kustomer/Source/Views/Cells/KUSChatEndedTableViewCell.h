//
//  KUSChatEndedTableViewCell.h
//  Kustomer
//
//  Created by BrainX Technologies on 02/07/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KUSChatEndedTableViewCell : UITableViewCell

@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) NSString *text UI_APPEARANCE_SELECTOR;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
