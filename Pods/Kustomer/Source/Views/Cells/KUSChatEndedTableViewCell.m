//
//  KUSChatEndedTableViewCell.m
//  Kustomer
//
//  Created by BrainX Technologies on 02/07/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KUSChatEndedTableViewCell.h"
#import "KUSLocalization.h"

@interface KUSChatEndedTableViewCell() {
    UILabel *chatEnd;
}
@end

@implementation KUSChatEndedTableViewCell

#pragma mark - Class methods

+ (void)initialize
{
     if (self == [KUSChatEndedTableViewCell class]) {
         KUSChatEndedTableViewCell *appearance = [KUSChatEndedTableViewCell appearance];
         [appearance setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.1]];
         [appearance setTextFont: [UIFont systemFontOfSize:15.0]];
         [appearance setTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
         [appearance setText: [[KUSLocalization sharedInstance] localizedString:@"CHAT HAS ENDED"]];
     }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        chatEnd = [[UILabel alloc] init];
        [chatEnd setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:chatEnd];
    }
    return self;
}

#pragma mark - Layout methods

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    chatEnd.frame = (CGRect) {
        .size.width = self.bounds.size.width,
        .size.height = self.bounds.size.height
    };
    [chatEnd setCenter: CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2)];
}

#pragma mark - UIAppearance methods

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    [chatEnd setFont:_textFont];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [chatEnd setTextColor:_textColor];
}

- (void)setText:(NSString *)text
{
    _text = text;
    chatEnd.text = _text;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundColor = backgroundColor;
    chatEnd.backgroundColor = backgroundColor;
}
@end
