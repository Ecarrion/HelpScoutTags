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

typedef enum : NSUInteger {
    Loading = 0,
    Error,
    Loaded,
} State;

@interface TagsViewModel : NSObject

// TODO: Represent error state
@property (nonatomic, strong, readonly) NSArray<TagViewModel *> *tagViewModels;
@property (nonatomic, strong, readonly) NSArray<TagViewModel *> *selectedViewModels;
@property (nonatomic, readonly) State state;

- (instancetype)initWithListedTags:(NSArray<TagViewModel *> *)listedTags
                       fromAllTags:(NSArray<TagViewModel *> *)allTags
                          andState:(State)state;

@end

NS_ASSUME_NONNULL_END
