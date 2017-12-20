//
//  TagsNetworkService.m
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsNetworkService.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsNetworkService ()

@property (nonatomic, strong, readwrite) Network *network;

@end

@implementation TagsNetworkService

- (instancetype)initWithNetwork:(Network *)network {
    self = [super init];
    if (self) {
        self.network = network;
    }
    return self;
}

//- (void)tagsOnCompletion:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completion

@end

NS_ASSUME_NONNULL_END
