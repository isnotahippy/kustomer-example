//
//  KUSNYTChatMessagePhoto.m
//  Kustomer
//
//  Created by Daniel Amitay on 8/27/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSNYTChatMessagePhoto.h"

#import <SDWebImage/SDWebImageManager.h>

#import "KUSChatMessage.h"

@interface KUSNYTChatMessagePhoto () {
    KUSChatMessage *_chatMessage;
}

@property (nonatomic, readwrite, nullable) UIImage *image;
@property (nonatomic, readwrite, nullable) NSData *imageData;

@end

@implementation KUSNYTChatMessagePhoto

- (instancetype)initWithChatMessage:(KUSChatMessage *)message
{
    self = [super init];
    if (self) {
        _chatMessage = message;

        __weak KUSNYTChatMessagePhoto *weakSelf = self;
        SDWebImageOptions options = SDWebImageHighPriority | SDWebImageScaleDownLargeImages;
        [[SDWebImageManager sharedManager]
         loadImageWithURL:_chatMessage.imageURL
         options:options
         progress:nil
         completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
             if (weakSelf == nil) {
                 return;
             }
             weakSelf.image = image;
             weakSelf.imageData = data;
             [weakSelf.photosController updatePhoto:weakSelf];
         }];
    }
    return self;
}

@end
