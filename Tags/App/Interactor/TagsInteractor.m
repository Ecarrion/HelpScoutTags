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
@property (nonatomic, strong, readwrite) TagsViewModel *viewModel;

@end

@implementation TagsInteractor

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network {
    self = [super init];
    if (self) {
        self.networkService = [[TagsNetworkService alloc] initWithNetwork: network];
    }
    return self;
}

- (void)requestTags {
    
    __weak TagsInteractor *weakSelf = self;
    [self.networkService tagsOnCompletion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
        
        if (error) {
            // TODO: handle error in view model
            return;
        }
        
        NSMutableArray *viewModels = [NSMutableArray array];
        for (Tag *tag in tags) {
            TagViewModel *viewModel = [[TagViewModel alloc] initWithTag: tag isSelected: false];
            [viewModels addObject:viewModel];
        }
        
        TagsViewModel *tagsViewModel = [[TagsViewModel alloc] initWithTags: viewModels.copy];
        [weakSelf updateViewModel:tagsViewModel];
    }];
}

- (void)toggleTagSelectionAtIndex:(NSInteger)index {
    
    TagViewModel *oldTag = self.viewModel.tagViewModels[index];
    TagViewModel *selectedTag = [[TagViewModel alloc] initWithTag:oldTag.tag isSelected:!oldTag.isSelected];
    
    NSMutableArray<TagViewModel *> *tags = self.viewModel.tagViewModels.mutableCopy;
    [tags replaceObjectAtIndex:index withObject:selectedTag];
    
    TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithTags:tags];
    [self updateViewModel:newViewModel];
}

- (void)updateViewModel:(TagsViewModel *)viewModel {
    self.viewModel = viewModel;
    [self.delegate interactor:self didUpdateViewModel:self.viewModel];
}

@end

NS_ASSUME_NONNULL_END
