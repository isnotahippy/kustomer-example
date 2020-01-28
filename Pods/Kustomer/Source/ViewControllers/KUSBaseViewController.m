//
//  KUSBaseViewController.m
//  Kustomer
//
//  Created by Daniel Amitay on 8/1/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSBaseViewController.h"

#import "KUSColor.h"
#import "KUSImage.h"
#import "KUSLocalization.h"

@interface KUSBaseViewController ()

@property (nonatomic, strong, null_resettable) UIActivityIndicatorView *loadingIndicatorView;
@property (nonatomic, strong, null_resettable) UIImageView *errorImageView;
@property (nonatomic, strong, null_resettable) UILabel *textLabel;
@property (nonatomic, strong, null_resettable) UIButton *retryButton;

@end

@implementation KUSBaseViewController

#pragma mark - View layout methods

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    BOOL isRTL = [[KUSLocalization sharedInstance] isCurrentLanguageRTL];
    self.navigationController.view.semanticContentAttribute = isRTL ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight;
    self.navigationController.navigationBar.semanticContentAttribute = isRTL ? UISemanticContentAttributeForceRightToLeft : UISemanticContentAttributeForceLeftToRight;
    
    CGPoint iconCenterPoint = (CGPoint) {
        .x = self.view.bounds.size.width / 2.0,
        .y = self.view.bounds.size.height / 2.5
    };
    _loadingIndicatorView.center = iconCenterPoint;
    _errorImageView.center = iconCenterPoint;

    CGSize maxLabelSize = CGSizeMake(self.view.bounds.size.width - 80.0, CGFLOAT_MAX);
    CGSize textLabelSize = [_textLabel sizeThatFits:maxLabelSize];
    textLabelSize.width = MIN(ceil(textLabelSize.width), maxLabelSize.width);
    _textLabel.frame = (CGRect) {
        .origin.x = (self.view.bounds.size.width - textLabelSize.width) / 2.0,
        .origin.y = iconCenterPoint.y + 25.0,
        .size = textLabelSize
    };

    _retryButton.frame = (CGRect) {
        .origin.x = (self.view.bounds.size.width - 120.0) / 2.0,
        .origin.y = CGRectGetMaxY(_textLabel.frame) + 16.0,
        .size.width = 120.0,
        .size.height = 28.0
    };
}

#pragma mark - Public methods

- (UIEdgeInsets)edgeInsets
{
    UIEdgeInsets insets = UIEdgeInsetsZero;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
	if (@available(ios 11.0, *)) {
        insets.top = self.view.safeAreaInsets.top;
        insets.bottom = self.view.safeAreaInsets.bottom;
    } else {
        insets.top = self.topLayoutGuide.length;
        insets.bottom = self.bottomLayoutGuide.length;
    }
#else
    insets.top = self.topLayoutGuide.length;
    insets.bottom = self.bottomLayoutGuide.length;
#endif

    // iOS 11 on iPhone X doesn't correctly set the bottom insets if there is a toolbar,
    // unfortunately that means we need to special-case with the toolbar frame
    UIToolbar *toolbar = self.navigationController.toolbar;
    if (toolbar) {
        CGRect toolbarFrame = [toolbar convertRect:toolbar.bounds toView:self.view];
        CGFloat toolbarHeight = self.view.bounds.size.height - toolbarFrame.origin.y;
        insets.bottom = MAX(insets.bottom, toolbarHeight);
    }

    return insets;
}

- (void)showLoadingIndicatorWithText:(NSString *)text
{
    [self.loadingIndicatorView startAnimating];
    if (text.length == 0) {
        _textLabel.text = nil;
        _textLabel.hidden = YES;
    } else {
        self.textLabel.text = text;
        self.textLabel.hidden = NO;
    }
    _errorImageView.hidden = YES;
    _retryButton.hidden = YES;
    [self.view setNeedsLayout];
}

- (void)showLoadingIndicator
{
    [self showLoadingIndicatorWithText:nil];
}

- (void)hideLoadingIndicator
{
    [_loadingIndicatorView stopAnimating];
    _textLabel.text = nil;
    _textLabel.hidden = YES;
    _errorImageView.hidden = YES;
    _retryButton.hidden = YES;
}

- (void)showErrorWithText:(NSString *)text
{
    [_loadingIndicatorView stopAnimating];
    self.textLabel.text = text;
    self.errorImageView.hidden = NO;
    self.retryButton.hidden = NO;
    [self.view setNeedsLayout];
}

#pragma mark - Subclassable methods

- (void)userTappedRetryButton
{

}

#pragma mark - Property methods

- (UIActivityIndicatorView *)loadingIndicatorView
{
    if (_loadingIndicatorView == nil) {
        _loadingIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingIndicatorView.hidesWhenStopped = YES;
        _loadingIndicatorView.layer.zPosition = 1.0;
        [self.view addSubview:_loadingIndicatorView];
    }
    return _loadingIndicatorView;
}

- (UIImageView *)errorImageView
{
    if (_errorImageView == nil) {
        _errorImageView = [[UIImageView alloc] initWithImage:[KUSImage errorImage]];
        _errorImageView.layer.zPosition = 1.0;
        [self.view addSubview:_errorImageView];
    }
    return _errorImageView;
}

- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [KUSColor darkGrayColor];
        _textLabel.font = [UIFont systemFontOfSize:12.0];
        _textLabel.layer.zPosition = 1.0;
        [self.view addSubview:_textLabel];
    }
    return _textLabel;
}

- (UIButton *)retryButton
{
    if (_retryButton == nil) {
        CGFloat buttonRadius = 3.0;
        CGSize size = CGSizeMake(buttonRadius * 2.0, buttonRadius * 2.0);
        UIImage *circularImage = [KUSImage circularImageWithSize:size color:[KUSColor redColor]];
        UIEdgeInsets capInsets = UIEdgeInsetsMake(buttonRadius, buttonRadius, buttonRadius, buttonRadius);
        UIImage *buttonImage = [circularImage resizableImageWithCapInsets:capInsets];

        _retryButton = [[UIButton alloc] init];
        [_retryButton setTitle:[[KUSLocalization sharedInstance] localizedString:@"Try Again"] forState:UIControlStateNormal];
        _retryButton.titleLabel.textColor = [UIColor whiteColor];
        _retryButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_retryButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        _retryButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        _retryButton.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        _retryButton.layer.shadowRadius = 1.0;
        _retryButton.layer.shadowOpacity = 0.5;
        _retryButton.layer.zPosition = 1.0;

        [_retryButton addTarget:self
                         action:@selector(userTappedRetryButton)
               forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:_retryButton];
    }
    return _retryButton;
}

@end
