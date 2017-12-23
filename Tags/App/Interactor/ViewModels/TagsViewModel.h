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

/// Tags to be displayed in the table view
@property (nonatomic, strong, readonly) NSArray<TagViewModel *> *tagViewModels;

/// Selected tags to be displayed in the collectionView
@property (nonatomic, strong, readonly) NSArray<TagViewModel *> *selectedViewModels;

/// Current state of the view
@property (nonatomic, readonly) State state;

- (instancetype)initWithListedTags:(NSArray<TagViewModel *> *)listedTags
                       fromAllTags:(NSArray<TagViewModel *> *)allTags
                          andState:(State)state;

@end

NS_ASSUME_NONNULL_END
