//
//  KUSNYTChatMessagePhoto.h
//  Kustomer
//
//  Created by Daniel Amitay on 8/27/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NYTPhotoViewer/NYTPhoto.h>
#import <NYTPhotoViewer/NYTPhotosViewController.h>

@class KUSChatMessage;
@interface KUSNYTChatMessagePhoto : NSObject <NYTPhoto>

@property (nonatomic, readonly, nullable) UIImage *image;
@property (nonatomic, readonly, nullable) NSData *imageData;
@property (nonatomic, readonly, nullable) UIImage *placeholderImage;
@property (nonatomic, readonly, nullable) NSAttributedString *attributedCaptionTitle;
@property (nonatomic, readonly, nullable) NSAttributedString *attributedCaptionSummary;
@property (nonatomic, readonly, nullable) NSAttributedString *attributedCaptionCredit;

@property (nonatomic, weak, nullable) NYTPhotosViewController *photosController;

- (instancetype _Nullable)initWithChatMessage:(KUSChatMessage *_Nonnull)message;

@end
