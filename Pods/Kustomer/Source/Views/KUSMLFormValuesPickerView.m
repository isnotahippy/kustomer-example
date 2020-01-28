//
//  KUSMLFormValuesPickerView.m
//  Kustomer
//
//  Created by BrainX Technologies on 03/10/2018.
//  Copyright © 2018 Kustomer. All rights reserved.
//

#import "KUSMLFormValuesPickerView.h"
#import "KUSColor.h"
#import "KUSImage.h"
#import "KUSFadingButton.h"
#import "KUSOptionPickerView.h"
#import "KUSMLFormValuesPickerCollectionViewCell.h"
#import "KUSLocalization.h"
#import "KUSInputBar.h"

static const CGSize kKUSMLFormValueCellMinimumSize = {50, 50};
static const CGFloat kKUSMLFormValueSendButtonSize = 50.0;
static const CGFloat kKUSMLFormValueCollectionViewCellTextPadding = 15.0;

static NSString *kCellIdentifier = @"MLFormValueCell";


@interface KUSMLFormValuesPickerView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, KUSOptionPickerViewDelegate> {
    CGFloat optionPickerHeight;
    CGFloat mlCollectionViewHeight;
    UIView *_separatorView;
}

@property(nonatomic, strong) KUSOptionPickerView *optionPickerView;
@property(nonatomic, strong) UICollectionView *mlSelectedValueCollectionView;
@property (nonatomic, strong, readwrite) UIButton *sendButton;
@property (nonatomic, copy) NSMutableArray<KUSMLNode *> *mlFormValues;
@property (nonatomic, copy) NSMutableArray<KUSMLNode *> *currentOptionsToShow;
@property (nonatomic, copy) NSMutableArray<KUSMLNode *> *selectedValuesStack;
@property (nonatomic, assign) BOOL lastNodeRequired;
@property (nonatomic, assign) BOOL needOptionPicker;

@end

@implementation KUSMLFormValuesPickerView

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [KUSMLFormValuesPickerView class]) {
        KUSMLFormValuesPickerView *appearance = [KUSMLFormValuesPickerView appearance];
        [appearance setSeparatorColor:[KUSColor lightGrayColor]];
        [appearance setBackgroundColor:[UIColor whiteColor]];
    }
}

#pragma mark - Lifecycle methods

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _optionPickerView = [[KUSOptionPickerView alloc] init];
        _optionPickerView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
        _optionPickerView.delegate = self;
        [self addSubview:_optionPickerView];
        
        _separatorView = [[UIView alloc] init];
        [self addSubview:_separatorView];
        
        UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        collectionViewLayout.itemSize = kKUSMLFormValueCellMinimumSize;
        collectionViewLayout.minimumInteritemSpacing = 0.0;
        collectionViewLayout.minimumLineSpacing = 0.0;
        _mlSelectedValueCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
        _mlSelectedValueCollectionView.alwaysBounceHorizontal = NO;
        _mlSelectedValueCollectionView.bounces = NO;
        _mlSelectedValueCollectionView.bouncesZoom = NO;
        _mlSelectedValueCollectionView.showsHorizontalScrollIndicator = NO;
        _mlSelectedValueCollectionView.dataSource = self;
        _mlSelectedValueCollectionView.delegate = self;
        [_mlSelectedValueCollectionView registerClass:[KUSMLFormValuesPickerCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [self addSubview:_mlSelectedValueCollectionView];
        
        _sendButton = [[UIButton alloc] init];
        UIColor *sendButtonColor = [[KUSInputBar appearance] sendButtonColor];
        UIImage *sendButtonImage = [KUSImage sendImageWithSize:CGSizeMake(30.0, 30.0) color:sendButtonColor];
        [_sendButton setImage:sendButtonImage forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(_pressSend) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
        
        [self _updateSendButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    BOOL isRTL = [[KUSLocalization sharedInstance] isCurrentLanguageRTL];
    optionPickerHeight = _needOptionPicker ? [_optionPickerView desiredHeight] : 0;
    _optionPickerView.frame = (CGRect) {
        .origin.x = self.frame.origin.x,
        .origin.y = self.bounds.origin.y,
        .size.width = self.bounds.size.width,
        .size.height = optionPickerHeight
    };
    
    [_optionPickerView setHidden:!_needOptionPicker];
    
    CGFloat horizontalSeparatorViewHeight = 1.0;
    CGFloat horizontalSeparatorViewY = self.bounds.origin.y + optionPickerHeight;
    _separatorView.frame = (CGRect) {
        .origin.x = self.frame.origin.x,
        .origin.y = horizontalSeparatorViewY,
        .size.height = horizontalSeparatorViewHeight,
        .size.width = self.bounds.size.width
    };
    
    CGFloat mlCollectionViewY = horizontalSeparatorViewY + horizontalSeparatorViewHeight;
    mlCollectionViewHeight = [self getCollectionViewHeight];
    _mlSelectedValueCollectionView.frame = (CGRect) {
        .origin.x = isRTL ? self.frame.origin.x + kKUSMLFormValueSendButtonSize : self.frame.origin.x,
        .origin.y = mlCollectionViewY,
        .size.width = self.bounds.size.width - kKUSMLFormValueSendButtonSize,
        .size.height = mlCollectionViewHeight
    };
    
    if (isRTL) {
        [_mlSelectedValueCollectionView setTransform:CGAffineTransformMakeScale(-1, 1)];
    }
    
    self.sendButton.frame = (CGRect) {
        .origin.x = isRTL ? 0.0 : self.bounds.size.width - kKUSMLFormValueSendButtonSize,
        .origin.y = self.bounds.size.height - kKUSMLFormValueSendButtonSize,
        .size.width = kKUSMLFormValueSendButtonSize,
        .size.height = kKUSMLFormValueSendButtonSize
    };
    
}

#pragma mark - Public methods

- (CGFloat)desiredHeight
{
    return optionPickerHeight + mlCollectionViewHeight + 1;
}

- (void)setMLFormValuesPicker:(NSArray<KUSMLNode *> *)mlFormValues with:(BOOL)lastNodeRequired
{
    _mlFormValues = [[NSMutableArray alloc] initWithArray:mlFormValues];
    _currentOptionsToShow = [[NSMutableArray alloc] initWithArray:mlFormValues];
    _selectedValuesStack = [[NSMutableArray alloc] init];
    _lastNodeRequired = lastNodeRequired;
    [self showCurrentOptionsAndUpdateView];
}

#pragma mark - Internal logic methods

- (CGSize)getCellSizeWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    [label setText:text];
    [label setFont:[[KUSMLFormValuesPickerCollectionViewCell appearance] textFont]];
    [label sizeToFit];
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentCenter;
    CGSize size = label.bounds.size;
    size.height = MAX(size.height, kKUSMLFormValueCellMinimumSize.height);
    size.width = MAX(size.width + (2 * kKUSMLFormValueCollectionViewCellTextPadding), kKUSMLFormValueCellMinimumSize.width);
    return size;
}

- (CGFloat)getCollectionViewHeight
{
    CGSize size = [self getCellSizeWithText:[[KUSLocalization sharedInstance] localizedString:@"Home"]];
    return size.height;
}

- (void)_updateSendButton
{
    BOOL shouldEnableSend = NO;
    if (_selectedValuesStack.count > 0) {
        shouldEnableSend = _lastNodeRequired ? _selectedValuesStack.lastObject.nodeChilds.count == 0 : YES;
    }
    _sendButton.userInteractionEnabled = shouldEnableSend;
    _sendButton.alpha = shouldEnableSend ? 1.0 : 0.5;
}

- (void)_pressSend
{
    if ([self.delegate respondsToSelector:@selector(mlFormValuesPickerView:didSelect:with:)]) {
        [self.delegate mlFormValuesPickerView:self didSelect:_selectedValuesStack.lastObject.displayName with:_selectedValuesStack.lastObject.nodeId];
    }
}

- (void)showCurrentOptionsAndUpdateView
{
    if (_currentOptionsToShow.count == 0) {
        _needOptionPicker = NO;
    }
    else {
        _needOptionPicker = YES;
        NSMutableArray<NSString *> *currentOptionsValues = [[NSMutableArray alloc]initWithCapacity:_currentOptionsToShow.count];
        for (KUSMLNode* option in _currentOptionsToShow) {
            [currentOptionsValues addObject:option.displayName];
        }
        [_optionPickerView setOptions:currentOptionsValues];
    }
    [self _updateSendButton];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    if ([self.delegate respondsToSelector:@selector(mlFormValuesPickerViewHeightDidChange:)])
    {
        [self.delegate mlFormValuesPickerViewHeightDidChange:self];
    }
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:_selectedValuesStack.count inSection:0];
    [_mlSelectedValueCollectionView reloadData];
    [_mlSelectedValueCollectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _selectedValuesStack.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KUSMLFormValuesPickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if (_selectedValuesStack.count == 0) {
        [cell setMLFormValue:[[KUSLocalization sharedInstance] localizedString:@"Please select an item"] withSeparator:NO andSelectedTextColor:NO];
    }
    else {
        BOOL isFirst = indexPath.row == 0;
        BOOL isLast = indexPath.row == _selectedValuesStack.count;
        if (isFirst) {
            [cell setMLFormValue:[[KUSLocalization sharedInstance] localizedString:@"Home"] withSeparator:NO andSelectedTextColor:NO];
        }
        else {
            [cell setMLFormValue:_selectedValuesStack[indexPath.row-1].displayName withSeparator:YES andSelectedTextColor:isLast];
        }
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedValuesStack.count == 0) {
        return;
    }
    NSRange rangeToRemove = NSMakeRange(indexPath.row, _selectedValuesStack.count - indexPath.row);
    [_selectedValuesStack removeObjectsInRange:rangeToRemove];
    
    if (indexPath.row == 0) {
        _currentOptionsToShow = [[NSMutableArray alloc] initWithArray:_mlFormValues];
    }
    else {
        _currentOptionsToShow = [[NSMutableArray alloc] initWithArray:_selectedValuesStack[indexPath.row - 1].nodeChilds];
    }
    [self showCurrentOptionsAndUpdateView];
}

#pragma mark - UICollectionViewFlowLayoutDelegate methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedValuesStack.count == 0) {
        return [self getCellSizeWithText:[[KUSLocalization sharedInstance] localizedString:@"Please select an item"]];
    }
    else {
        if (indexPath.row == 0) {
            return [self getCellSizeWithText:[[KUSLocalization sharedInstance] localizedString:@"Home"]];
        }
        else {
            return [self getCellSizeWithText:_selectedValuesStack[indexPath.row-1].displayName];
        }
    }
}

#pragma mark - KUSOptionPickerViewDelegate methods

- (void)optionPickerView:(KUSOptionPickerView *)pickerView didSelectOption:(NSString *)option
{
    NSUInteger optionIndex = [pickerView.options indexOfObject:option];
    
    if (optionIndex != NSNotFound && optionIndex < _currentOptionsToShow.count) {
        [_selectedValuesStack addObject:_currentOptionsToShow[optionIndex]];
    }
    [_currentOptionsToShow removeAllObjects];
    
    if (_selectedValuesStack.count > 0 && _selectedValuesStack.lastObject.nodeChilds.count > 0) {
        _currentOptionsToShow = [[NSMutableArray alloc] initWithArray:_selectedValuesStack.lastObject.nodeChilds];
    }
    [self showCurrentOptionsAndUpdateView];
}

#pragma mark - UIAppearance methods

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundColor = backgroundColor;
    _mlSelectedValueCollectionView.backgroundColor = backgroundColor;
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    _separatorView.backgroundColor = separatorColor;
}

@end
