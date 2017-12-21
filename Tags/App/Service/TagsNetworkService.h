//
//  TagsNetworkService.h
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Network.h"
#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TagsNetworkType

@property (readonly) NSObject<NetworkType> *network;

- (void)tagsOnCompletion:(void (^)(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error))completion;

@end

@interface TagsNetworkService : NSObject<TagsNetworkType>

@property (nonatomic, strong, readonly) Network *network;

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network;

@end

NS_ASSUME_NONNULL_END
