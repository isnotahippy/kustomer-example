//
//  KUSEditFeedbackTableViewCell.m
//  Kustomer
//
//  Created by BrainX Technologies on 16/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import "KUSEditFeedbackTableViewCell.h"
#import "KUSLocalization.h"
#import "KUSImage.h"
#import "KUSColor.h"
#import "KUSText.h"
#import "KUSAvatarImageView.h"
#import "KUSChatMessageTableViewCell.h"

static const CGFloat kCellVerticalPadding = 11.0;
static const CGFloat kAvatarDiameter = 40.0;
static const CGFloat kFormPaddingFromCellOnAvatarSide = 60.0;
static const CGFloat kRowSidePadding = 11.0;
static const CGFloat kMaximumFormWidth = 300.0;
static const CGFloat kFeedbackSentIconDiameter = 50.0;

@interface KUSEditFeedbackTableViewCell () {
    UIView *_bubbleView;
    KUSAvatarImageView *_avatarImageView;
    UIImageView *_feedbackSentIcon;
    UILabel *_feedbackLabel;
    UIButton *_editButton;
    BOOL showEditButton;
}

@end

@implementation KUSEditFeedbackTableViewCell

#pragma mark - Class methods

+ (CGFloat)heightForEditFeedbackCellWithEditButton:(BOOL)editButton maxWidth:(CGFloat)maxWidth
{
    CGFloat maxWidthForForm = MIN(maxWidth - kRowSidePadding - kFormPaddingFromCellOnAvatarSide, kMaximumFormWidth);
    CGFloat maxWidthForFormContent = maxWidthForForm - (kRowSidePadding * 2);
    CGFloat height = (kCellVerticalPadding * 4);
    
    height += kFeedbackSentIconDiameter;
    height += kCellVerticalPadding;
    
    KUSEditFeedbackTableViewCell *appearance = [KUSEditFeedbackTableViewCell appearance];
    
    height += [self boundingSizeForText:appearance.feedbackText
                               maxWidth:maxWidthForFormContent
                                   font:appearance.feedbackTextFont].height;
    height += kCellVerticalPadding;
    
    if (!editButton) {
        height += kCellVerticalPadding;
        return height;
    }
    height += [self boundingSizeForText:appearance.editText
                               maxWidth:maxWidthForFormContent
                                   font:appearance.editTextFont].height;
    height += (kCellVerticalPadding * 2);
    return height;
}

+ (CGSize)boundingSizeForText:(NSString *)text maxWidth:(CGFloat)maxWidth font:(UIFont *)font
{
    NSAttributedString *attributedString = [KUSText attributedStringFromText:text fontSize:font.pointSize];
    
    CGSize maxSize = CGSizeMake(maxWidth, 1000.0);
    CGRect boundingRect = [attributedString boundingRectWithSize:maxSize
                                                         options:(NSStringDrawingUsesLineFragmentOrigin
                                                                  | NSStringDrawingUsesFontLeading)
                                                         context:nil];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize boundingSize = boundingRect.size;
    boundingSize.width = ceil(boundingSize.width * scale) / scale;
    boundingSize.height = ceil(boundingSize.height * scale) / scale;
    return boundingSize;
}

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSEditFeedbackTableViewCell class]) {
        KUSEditFeedbackTableViewCell *appearance = [KUSEditFeedbackTableViewCell appearance];
        [appearance setFeedbackTextFont: [UIFont boldSystemFontOfSize:15.0]];
        [appearance setFeedbackTextColor: [UIColor blackColor]];
        [appearance setFeedbackText: [[KUSLocalization sharedInstance] localizedString:@"feedback_thankyou"]];
        [appearance setEditTextFont: [UIFont systemFontOfSize:14.0]];
        [appearance setEditTextColor: [KUSColor blueColor]];
        [appearance setEditText: [[KUSLocalization sharedInstance] localizedString:@"Edit"]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier userSession:(KUSUserSession *)userSession
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [super setBackgroundColor:[[KUSChatMessageTableViewCell appearance] backgroundColor]];
        
        _bubbleView = [[UIView alloc] init];
        _bubbleView.layer.masksToBounds = YES;
        [_bubbleView setBackgroundColor:[[KUSChatMessageTableViewCell appearance] companyBubbleColor]];
        [self.contentView addSubview:_bubbleView];
        
        _feedbackSentIcon = [[UIImageView alloc] init];
        [_feedbackSentIcon setImage:[KUSImage tickImage]];
        [_bubbleView addSubview:_feedbackSentIcon];
        
        _feedbackLabel = [[UILabel alloc] init];
        [_feedbackLabel setTextAlignment:NSTextAlignmentCenter];
        [_bubbleView addSubview:_feedbackLabel];
        
        _editButton = [[UIButton alloc] init];
        _editButton.backgroundColor = [UIColor clearColor];
        [_editButton addTarget:self action:@selector(_onButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_bubbleView addSubview:_editButton];
        
        _avatarImageView = [[KUSAvatarImageView alloc] initWithUserSession:userSession];
        [self.contentView addSubview:_avatarImageView];
    }
    return self;
}

#pragma mark - Layout methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    BOOL isRTL = [[KUSLocalization sharedInstance] isCurrentLanguageRTL];
    
    CGFloat availableFormWidth = self.contentView.bounds.size.width - kRowSidePadding - kFormPaddingFromCellOnAvatarSide;
    CGFloat actualFormWidth = MIN(availableFormWidth, kMaximumFormWidth);
    
    CGFloat bubbleViewOriginXForRTL = self.contentView.bounds.size.width - actualFormWidth - kFormPaddingFromCellOnAvatarSide;
    _bubbleView.frame = (CGRect) {
        .origin.x = isRTL ? bubbleViewOriginXForRTL : kFormPaddingFromCellOnAvatarSide,
        .origin.y = (kCellVerticalPadding * 2),
        .size.width = actualFormWidth,
        .size.height = self.contentView.bounds.size.height - (3 * kCellVerticalPadding)
    };
    _bubbleView.layer.cornerRadius = 15.0;
    
    _feedbackSentIcon.frame = (CGRect) {
        .size = CGSizeMake(kFeedbackSentIconDiameter, kFeedbackSentIconDiameter)
    };
    [_feedbackSentIcon setCenter:CGPointMake(_bubbleView.bounds.size.width/2, (kCellVerticalPadding * 2) + (kFeedbackSentIconDiameter / 2))];
    
    CGFloat maxContentWidth = _bubbleView.bounds.size.width - (kRowSidePadding * 2);
    CGSize boundingSizeForFeedbackLabel = [[self class] boundingSizeForText:_feedbackLabel.text
                                                                          maxWidth:maxContentWidth
                                                                              font:_feedbackTextFont];
    
    _feedbackLabel.frame = (CGRect) {
        .origin.y = _feedbackSentIcon.frame.origin.y + kFeedbackSentIconDiameter + kCellVerticalPadding,
        .origin.x = kRowSidePadding,
        .size.width = maxContentWidth,
        .size.height = boundingSizeForFeedbackLabel.height
    };
    
    if (showEditButton) {
        CGSize boundingSizeForEditButton = [[self class] boundingSizeForText:_editText
                                                                    maxWidth:maxContentWidth
                                                                        font:_editTextFont];
        _editButton.frame = (CGRect) {
            .size = boundingSizeForEditButton
        };
        CGFloat editButtonOriginY = _feedbackLabel.frame.origin.y + boundingSizeForFeedbackLabel.height + kCellVerticalPadding;
        CGFloat editButtonCenterY = editButtonOriginY + (boundingSizeForEditButton.height/2);
        [_editButton setCenter:CGPointMake(_bubbleView.bounds.size.width/2, editButtonCenterY)];
    } else {
        _editButton.frame = CGRectZero;
    }
    
    CGFloat avatarOriginXForRTL = self.contentView.bounds.size.width - kRowSidePadding - kAvatarDiameter;
    _avatarImageView.frame = (CGRect) {
        .origin.x = isRTL ? avatarOriginXForRTL : kRowSidePadding,
        .origin.y = self.contentView.bounds.size.height - kAvatarDiameter - kCellVerticalPadding,
        .size.width = kAvatarDiameter,
        .size.height = kAvatarDiameter
    };
}

#pragma mark - Internal methods

- (void)_onButtonPress:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(editFeedbackTableViewCellDidEditButtonPressed:)]) {
        [self.delegate editFeedbackTableViewCellDidEditButtonPressed:self];
    }
}

#pragma mark - Public methods

- (void)setEditButtonShow:(BOOL)status
{
    showEditButton = status;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - UIAppearance methods

- (void)setFeedbackTextFont:(UIFont *)feedbackTextFont
{
    _feedbackTextFont = feedbackTextFont;
    [_feedbackLabel setFont:_feedbackTextFont];
}

- (void)setFeedbackTextColor:(UIColor *)feedbackTextColor
{
    _feedbackTextColor = feedbackTextColor;
    [_feedbackLabel setTextColor:_feedbackTextColor];
}

- (void)setFeedbackText:(NSString *)feedbackText
{
    _feedbackText = feedbackText;
    [_feedbackLabel setText:_feedbackText];
}

- (void)setEditTextFont:(UIFont *)editTextFont
{
    _editTextFont = editTextFont;
    [_editButton.titleLabel setFont:_editTextFont];
}

- (void)setEditTextColor:(UIColor *)editTextColor
{
    _editTextColor = editTextColor;
    [_editButton setTitleColor:_editTextColor forState:UIControlStateNormal];
}

- (void)setEditText:(NSString *)editText
{
    _editText = editText;
    [_editButton setTitle:_editText forState:UIControlStateNormal];
}

@end
