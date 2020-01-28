//
//  KUSTextView.h
//  Kustomer
//
//  Created by Daniel Amitay on 7/24/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KUSTextView;
@protocol KUSTextViewDelegate <UITextViewDelegate>

@optional
- (BOOL)textViewCanPasteImage:(KUSTextView *)textView;
- (void)textView:(KUSTextView *)textView didPasteImage:(UIImage *)image;

@end

@interface KUSTextView : UITextView

@property (nonatomic, weak) id<KUSTextViewDelegate> delegate;

@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) NSString *placeholder;

- (NSUInteger)maxNumberOfLines;
- (NSUInteger)numberOfLines;
- (CGFloat)desiredHeight;

@end
