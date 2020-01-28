//
//  KUSRatingView.h
//  Kustomer
//
//  Created by BrainX Technologies on 12/04/2019.
//  Copyright © 2019 Kustomer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KUSSatisfactionForm.h"

@protocol KUSRatingViewDelegate;

@interface KUSRatingView : UIView

@property (nonatomic, strong) UIColor *highScaleLabelColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *lowScaleLabelColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIFont *highScaleLabelFont UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *lowScaleLabelFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, weak) id<KUSRatingViewDelegate> delegate;

+ (CGFloat)heightOfRatingViewForForm:(KUSSatisfactionForm *)satisfactionForm maxWidth:(CGFloat)maxWidth;
- (void)setRatingOptions:(KUSSatisfactionScaleType)type optionsCount:(NSInteger)count highScaleLabel:(NSString *)highScale lowScaleLabel:(NSString *)lowScale selectedRating:(NSInteger)rating;
- (void)setBackgroundColor:(UIColor *)backgroundColor NS_UNAVAILABLE;

@end

@protocol KUSRatingViewDelegate <NSObject>

@optional
- (void)ratingView:(KUSRatingView *)ratingView didSelectRating:(NSInteger)rating;

@end
