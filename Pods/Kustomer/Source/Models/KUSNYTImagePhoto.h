//
//  KUSNYTImagePhoto.h
//  Kustomer
//
//  Created by Daniel Amitay on 12/30/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NYTPhotoViewer/NYTPhoto.h>

@interface KUSNYTImagePhoto : NSObject <NYTPhoto>

- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)init NS_UNAVAILABLE;

@end
