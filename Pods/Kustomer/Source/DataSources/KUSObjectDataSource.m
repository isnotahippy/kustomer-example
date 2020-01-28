//
//  KUSObjectDataSource.m
//  Kustomer
//
//  Created by Daniel Amitay on 7/29/17.
//  Copyright © 2017 Kustomer. All rights reserved.
//

#import "KUSObjectDataSource.h"
#import "KUSObjectDataSource_Private.h"

@interface KUSObjectDataSource () {
    NSHashTable<id<KUSObjectDataSourceListener>> *_listeners;
}

@property (nonatomic, readwrite) BOOL isFetching;
@property (nonatomic, readwrite) BOOL didFetch;
@property (nonatomic, strong, readwrite) NSError *error;
@property (nonatomic, strong, readwrite) __kindof KUSModel *object;

@property (nonatomic, weak, readwrite) KUSUserSession *userSession;

@property (nonatomic, strong, nullable) NSObject *requestMarker;

@end

@implementation KUSObjectDataSource

#pragma mark - Lifecycle methods

- (instancetype)initWithUserSession:(KUSUserSession *)userSession
{
    self = [super init];
    if (self) {
        _userSession = userSession;

        _listeners = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}

#pragma mark - Request methods

- (void)fetch
{
    if (self.isFetching) {
        return;
    }
    self.isFetching = YES;
    self.error = nil;

    NSObject *requestMarker = [[NSObject alloc] init];
    self.requestMarker = requestMarker;

    __weak KUSObjectDataSource *weakSelf = self;
    [self performRequestWithCompletion:^(NSError *error, NSDictionary *response) {
        __strong KUSObjectDataSource *strongSelf = weakSelf;
        if (strongSelf == nil) {
            return;
        }
        // Check to make sure that the request marker did not change
        if (strongSelf.requestMarker != requestMarker) {
            return;
        }
        strongSelf.requestMarker = nil;

        KUSModel *model = [[[strongSelf modelClass] alloc] initWithJSON:response[@"data"]];
        [model addIncludedWithJSON:response[@"included"]];

        strongSelf.isFetching = NO;
        if (error || model == nil) {
            strongSelf.error = error ?: [NSError new];
            [strongSelf notifyAnnouncersDidError:strongSelf.error];
        } else {
            strongSelf.object = model;
            strongSelf.didFetch = YES;
            [strongSelf notifyAnnouncersDidLoad];
        }
    }];
}

- (void)cancel
{
    self.isFetching = NO;
    self.requestMarker = nil;
}

#pragma mark - Subclass methods

- (void)performRequestWithCompletion:(KUSRequestCompletion)completion {}

- (Class)modelClass
{
    return [KUSModel class];
}

#pragma mark - Listener methods

- (void)addListener:(id<KUSObjectDataSourceListener>)listener
{
    [_listeners addObject:listener];
}

- (void)removeListener:(id<KUSObjectDataSourceListener>)listener
{
    [_listeners removeObject:listener];
}

#pragma mark - Internal listener methods

- (void)notifyAnnouncersDidError:(NSError *)error
{
    for (id<KUSObjectDataSourceListener> listener in [_listeners copy]) {
        if ([listener respondsToSelector:@selector(objectDataSource:didReceiveError:)]) {
            [listener objectDataSource:self didReceiveError:error];
        }
    }
}

- (void)notifyAnnouncersDidLoad
{
    for (id<KUSObjectDataSourceListener> listener in [_listeners copy]) {
        if ([listener respondsToSelector:@selector(objectDataSourceDidLoad:)]) {
            [listener objectDataSourceDidLoad:self];
        }
    }
}

@end
