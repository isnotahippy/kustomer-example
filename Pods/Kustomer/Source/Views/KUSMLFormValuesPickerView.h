//
//  KUSMLFormValuesPickerView.h
//  Kustomer
//
//  Created by BrainX Technologies on 03/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUSMLNode.h"

@class KUSMLFormValuesPickerView;
@protocol KUSMLFormValuesPickerViewDelegate <NSObject>

@optional
- (void)mlFormValuesPickerView:(KUSMLFormValuesPickerView *)mlFormValuesPickerView didSelect:(NSString *)option with:(NSString *)optionId;
- (void)mlFormValuesPickerViewHeightDidChange:(KUSMLFormValuesPickerView *)mlFormValuesPickerView;

@end

@interface KUSMLFormValuesPickerView : UIView

@property (nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak) id<KUSMLFormValuesPickerViewDelegate> delegate;
@property (nonatomic, strong, readonly) UIButton *sendButton;

- (CGFloat)desiredHeight;
- (void)setMLFormValuesPicker:(NSArray<KUSMLNode *> *)mlFormValues with:(BOOL)lastNodeRequired;

@end
