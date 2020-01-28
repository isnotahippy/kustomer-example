//
//  KUSMLSelectedValueCollectionViewCell.h
//  Kustomer
//
//  Created by BrainX Technologies on 03/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KUSMLFormValuesPickerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *selectedTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;

- (void)setMLFormValue:(NSString *)value withSeparator:(BOOL)separator andSelectedTextColor:(BOOL)selectedTextColor;
@end
