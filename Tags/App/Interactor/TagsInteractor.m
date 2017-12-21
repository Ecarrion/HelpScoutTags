//
//  TagsInteractor.m
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsInteractor ()

@property (nonatomic, strong, readwrite) TagsNetworkService *networkService;

@end

@implementation TagsInteractor

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network {
    self = [super init];
    if (self) {
        self.networkService = [[TagsNetworkService alloc] initWithNetwork: network];
    }
    return self;
}

- (void)tagsOnCompletion:(void (^)(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error))completion {
    [self.networkService tagsOnCompletion: completion];
}

@end

NS_ASSUME_NONNULL_END
