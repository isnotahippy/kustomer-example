//
//  KUSEditFeedbackTableViewCell.h
//  Kustomer
//
//  Created by BrainX Technologies on 16/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUSUserSession.h"

@protocol KUSEditFeedbackTableViewCellDelegate;

@interface KUSEditFeedbackTableViewCell : UITableViewCell

@property (nonatomic, strong) UIFont *feedbackTextFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) NSString *feedbackText UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *feedbackTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *editTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *editTextFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) NSString *editText UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak) id<KUSEditFeedbackTableViewCellDelegate> delegate;

+ (CGFloat)heightForEditFeedbackCellWithEditButton:(BOOL)editButton maxWidth:(CGFloat)maxWidth;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier userSession:(KUSUserSession *)userSession;
- (void)setEditButtonShow:(BOOL)status;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (void)setBackgroundColor:(UIColor *)backgroundColor NS_UNAVAILABLE;
@end

@protocol KUSEditFeedbackTableViewCellDelegate <NSObject>

@optional
- (void)editFeedbackTableViewCellDidEditButtonPressed:(KUSEditFeedbackTableViewCell *)cell;

@end
