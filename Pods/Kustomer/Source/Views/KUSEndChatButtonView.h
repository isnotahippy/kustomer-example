//
//  KUSCloseChatButtonView.h
//  Kustomer
//
//  Created by BrainX Technologies on 28/06/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KUSCloseChatButtonViewDelegate;
@interface KUSEndChatButtonView: UIView

@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) NSString *text UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak) id<KUSCloseChatButtonViewDelegate> delegate;

@end

@protocol KUSCloseChatButtonViewDelegate <NSObject>

- (void)closeChatButtonTapped:(KUSEndChatButtonView *)closeChatButtonView;

@end
