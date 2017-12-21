//
//  TagsViewModel.h
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsViewModel : NSObject

// TODO: Represent error state
@property (nonatomic, strong, readonly) NSArray<TagViewModel *> *tagViewModels;

- (instancetype)initWithTags:(NSArray<TagViewModel *> *)tagViewModels;

@end

NS_ASSUME_NONNULL_END
