//
//  KUSEmailInputView.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/26/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KUSEmailInputViewDelegate;
@interface KUSEmailInputView : UIView

@property (nonatomic, copy) NSString *prompt UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *promptColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *promptFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) NSString *placeholder UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *placeholderFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *inputBackgroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak) id<KUSEmailInputViewDelegate> delegate;

@end

@protocol KUSEmailInputViewDelegate <NSObject>

- (void)emailInputView:(KUSEmailInputView *)inputView didSubmitEmail:(NSString *)email;

@end
