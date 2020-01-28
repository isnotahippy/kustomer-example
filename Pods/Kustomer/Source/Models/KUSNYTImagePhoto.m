//
//  KUSNYTImagePhoto.m
//  Kustomer
//
//  Created by Daniel Amitay on 12/30/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSNYTImagePhoto.h"

@interface KUSNYTImagePhoto ()

@property (nonatomic, readwrite, nullable) UIImage *image;
@property (nonatomic, readwrite, nullable) NSData *imageData;
@property (nonatomic, readwrite, nullable) UIImage *placeholderImage;
@property (nonatomic, readwrite, nullable) NSAttributedString *attributedCaptionTitle;
@property (nonatomic, readwrite, nullable) NSAttributedString *attributedCaptionSummary;
@property (nonatomic, readwrite, nullable) NSAttributedString *attributedCaptionCredit;

@end

@implementation KUSNYTImagePhoto

#pragma mark - Lifecycle methods

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.image = image;
    }
    return self;
}

@end
