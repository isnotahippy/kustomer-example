//
//  KUSPermissions.h
//  Kustomer
//
//  Created by Daniel Amitay on 11/11/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KUSPermissions : NSObject

+ (BOOL)cameraAccessIsAvailable;
+ (BOOL)photoLibraryAccessIsAvailable;

@end
