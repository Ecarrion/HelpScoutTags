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

@class TagsInteractor;

NS_ASSUME_NONNULL_BEGIN

@protocol TagsInteractorDelegate

- (void)interactor:(TagsInteractor *)interactor didUpdateViewModel:(TagsViewModel *)viewModel;

@end

@interface TagsInteractor : NSObject

@property (nonatomic, weak) id<TagsInteractorDelegate> delegate;
@property (nonatomic, strong, readonly) TagsViewModel * viewModel;

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network;

/// New tags will be delivered though the delegate methods
- (void)requestTags;

/// New tags will be delivered though the delegate methods
- (void)toggleTagSelectionAtIndex:(NSInteger)index;

/// Deselects a tag from it's main viewModel
- (void)deselectTag:(TagViewModel *)tagViewModel;

@end

NS_ASSUME_NONNULL_END
