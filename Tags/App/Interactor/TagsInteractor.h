//
//  TagsInteractor.h
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagsNetworkService.h"
#import "TagsViewModel.h"
#import "Network.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsInteractor : NSObject

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network;

- (void)tagsOnCompletion:(void (^)(TagsViewModel * _Nullable tags, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
