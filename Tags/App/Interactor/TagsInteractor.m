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
@property (nonatomic, strong, readwrite) NSMutableArray<TagViewModel *> *tags;

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
        
        self.tags = [NSMutableArray array];
        for (Tag *tag in tags) {
            TagViewModel *viewModel = [[TagViewModel alloc] initWithTag:tag isSelected:false];
            [self.tags addObject:viewModel];
        }
        
        TagsViewModel *tagsViewModel = [[TagsViewModel alloc] initWithTags:self.tags.copy];
        [weakSelf updateViewModel:tagsViewModel];
    }];
}

- (void)toggleTagSelectionAtIndex:(NSInteger)index {
    
    TagViewModel *oldTag = self.viewModel.tagViewModels[index];
    TagViewModel *selectedTag = [[TagViewModel alloc] initWithTag:oldTag.tag isSelected:!oldTag.isSelected];
    
    NSInteger indexInFullTags = [self.tags indexOfObject:oldTag];
    [self.tags replaceObjectAtIndex:indexInFullTags withObject:selectedTag];
    
    NSMutableArray<TagViewModel *> *curatedTags = self.viewModel.tagViewModels.mutableCopy;
    [curatedTags replaceObjectAtIndex:index withObject:selectedTag];
    
    TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithTags:curatedTags.copy];
    [self updateViewModel:newViewModel];
}

- (void)deselectTag:(TagViewModel *)tagViewModel {
    
    if (!tagViewModel.isSelected) {
        return;
    }
    
    // TODO: Handle when tag is not inside displayedViewModels
    NSInteger tagIndex = [self.viewModel.tagViewModels indexOfObject:tagViewModel];
    [self toggleTagSelectionAtIndex:tagIndex];
}

- (void)filtertTagsByQuery:(NSString *)query {
    
    if (query.length == 0) {
        TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithTags:self.tags.copy];
        [self updateViewModel:newViewModel];
        return;
    }
    
    NSPredicate * searchPredicate = [NSPredicate predicateWithBlock:^BOOL(TagViewModel *tagViewModel, NSDictionary<NSString *,id> *bindings) {
        return [tagViewModel.name localizedCaseInsensitiveContainsString:query];
    }];
    
    // TODO: handle showing tags that are not filtered
    NSArray<TagViewModel *> *filteredTags = [self.tags filteredArrayUsingPredicate:searchPredicate];
    TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithTags:filteredTags];
    [self updateViewModel:newViewModel];
}

- (void)updateViewModel:(TagsViewModel *)viewModel {
    self.viewModel = viewModel;
    [self.delegate interactor:self didUpdateViewModel:self.viewModel];
}

@end

NS_ASSUME_NONNULL_END
