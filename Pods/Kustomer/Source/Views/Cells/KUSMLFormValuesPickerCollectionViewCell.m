//
//  KUSMLSelectedValueCollectionViewCell.m
//  Kustomer
//
//  Created by BrainX Technologies on 03/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSMLFormValuesPickerCollectionViewCell.h"
#import "KUSColor.h"
#import "KUSLocalization.h"

static const CGFloat kKUSMLFormValuesPickerSeparatorWidth = 3.0;
static const CGFloat kKUSMLFormValuesPickerSeparatorPadding = 8.0;

@implementation KUSMLFormValuesPickerCollectionViewCell {
    UILabel *_valueLabel;
    UIView *_separator;
    
    BOOL isSelected;
}

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSMLFormValuesPickerCollectionViewCell class]) {
        KUSMLFormValuesPickerCollectionViewCell *appearance = [KUSMLFormValuesPickerCollectionViewCell appearance];
        [appearance setBackgroundColor: [UIColor whiteColor]];
        [appearance setSeparatorColor:[KUSColor lightGrayColor]];
        [appearance setTextFont:[UIFont systemFontOfSize:14.0]];
        [appearance setTextColor:[UIColor blackColor]];
        [appearance setSelectedTextColor:[[KUSColor blueColor] colorWithAlphaComponent:0.8]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        isSelected = NO;
        
        _separator = [[UIView alloc] init];
        [self.contentView addSubview:_separator];
        
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_valueLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    BOOL isRTL = [[KUSLocalization sharedInstance] isCurrentLanguageRTL];
    _separator.frame = (CGRect) {
        .origin.x = isRTL ? self.bounds.size.width - kKUSMLFormValuesPickerSeparatorWidth : self.bounds.origin.x,
        .origin.y = self.bounds.origin.y + kKUSMLFormValuesPickerSeparatorPadding,
        .size.width = kKUSMLFormValuesPickerSeparatorWidth,
        .size.height = self.bounds.size.height - (kKUSMLFormValuesPickerSeparatorPadding * 2)
    };
    _valueLabel.frame = (CGRect) {
        .origin.x = isRTL ? self.bounds.origin.x : self.bounds.origin.x + kKUSMLFormValuesPickerSeparatorWidth,
        .origin.y = self.bounds.origin.y,
        .size.width = self.bounds.size.width - kKUSMLFormValuesPickerSeparatorWidth,
        .size.height = self.bounds.size.height
    };
    _valueLabel.textColor = isSelected ? _selectedTextColor : _textColor;

    if (isRTL) {
        [self.contentView setTransform:CGAffineTransformMakeScale(-1, 1)];
    }
}

#pragma mark - UIAppearance methods

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.contentView.backgroundColor = backgroundColor;
    _valueLabel.backgroundColor = backgroundColor;
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    _separator.backgroundColor = separatorColor;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    _valueLabel.font = textFont;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _valueLabel.textColor = textColor;
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    _selectedTextColor = selectedTextColor;
}

#pragma mark - Public methods

- (void)setMLFormValue:(NSString *)value withSeparator:(BOOL)separator andSelectedTextColor:(BOOL)selectedTextColor
{
    isSelected = selectedTextColor;
    _separator.hidden = !separator;
    _valueLabel.text = value;
    _valueLabel.textColor = selectedTextColor ? _selectedTextColor : _textColor;
}
@end
