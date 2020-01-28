//
//  KUSOptionPickerView.h
//  Kustomer
//
//  Created by Daniel Amitay on 12/29/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KUSOptionPickerView;
@protocol KUSOptionPickerViewDelegate <NSObject>

@optional
- (void)optionPickerView:(KUSOptionPickerView *)pickerView didSelectOption:(NSString *)option;

@end

@class KUSPaginatedDataSource;
@interface KUSOptionPickerView : UIScrollView

@property (nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *buttonColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak) id<KUSOptionPickerViewDelegate> delegate;

@property (nonatomic, copy) NSArray<NSString *> *options;

- (CGFloat)desiredHeight;

@end
