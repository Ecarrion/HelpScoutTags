//
//  TagsInteractor.m
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsInteractor.h"
#import "TagsStorageService.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsInteractor ()

@property (nonatomic, strong, readwrite) TagsNetworkService *networkService;
@property (nonatomic, strong, readwrite) TagsStorageService *storageService;

@property (nonatomic, strong, readwrite) TagsViewModel *viewModel;
@property (nonatomic, strong, readwrite) NSMutableArray<TagViewModel *> *tags;

@end

@implementation TagsInteractor

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network {
    self = [super init];
    if (self) {
        self.networkService = [[TagsNetworkService alloc] initWithNetwork: network];
        self.storageService = [[TagsStorageService alloc] init];
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
        
        // Load previous selected tags
        NSArray<Tag *> *selectedTags = [self.storageService loadSelectedTags];
        
        // Create new viewModel
        self.tags = [NSMutableArray array];
        for (Tag *tag in tags) {
            Boolean isSelected = [selectedTags containsObject:tag];
            TagViewModel *viewModel = [[TagViewModel alloc] initWithTag:tag isSelected:isSelected];
            [self.tags addObject:viewModel];
        }
        
        
        TagsViewModel *tagsViewModel = [[TagsViewModel alloc] initWithListedTags:self.tags.copy fromAllTags:self.tags.copy];
        [weakSelf updateViewModel:tagsViewModel];
    }];
}

- (void)toggleSelectionOfTag:(TagViewModel *)tagViewModel {
    
    // If tag is not found return
    NSInteger indexInFullTags = [self.tags indexOfObject:tagViewModel];
    if (indexInFullTags == NSNotFound) {
        return;
    }
    
    // Toggle selection on tag
    TagViewModel *toggledTag = [[TagViewModel alloc] initWithTag:tagViewModel.tag isSelected:!tagViewModel.isSelected];
    
    //Replace in array of full tags
    [self.tags replaceObjectAtIndex:indexInFullTags withObject:toggledTag];
    
    // Replace in array of listed tags
    NSInteger indexOnListedTags = [self.viewModel.tagViewModels indexOfObject:tagViewModel];
    NSMutableArray<TagViewModel *> *listedTags = self.viewModel.tagViewModels.mutableCopy;
    if (indexOnListedTags != NSNotFound) {
        [listedTags replaceObjectAtIndex:indexOnListedTags withObject:toggledTag];
    }
    
    // Update the view model
    TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithListedTags:listedTags.copy fromAllTags:self.tags.copy];
    [self updateViewModel:newViewModel];
}

- (void)deselectTag:(TagViewModel *)tagViewModel {
    
    if (!tagViewModel.isSelected) {
        return;
    }
    
    [self toggleSelectionOfTag:tagViewModel];
}

- (void)filtertTagsByQuery:(NSString *)query {
    
    // If there is no search query, return a viewModel with all tags
    if (query.length == 0) {
        TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithListedTags:self.tags.copy fromAllTags:self.tags.copy];
        [self updateViewModel:newViewModel];
        return;
    }
    
    NSPredicate * searchPredicate = [NSPredicate predicateWithBlock:^BOOL(TagViewModel *tagViewModel, NSDictionary<NSString *,id> *bindings) {
        return [tagViewModel.name localizedCaseInsensitiveContainsString:query];
    }];
    
    // Filter tags using a a case insensitive compare
    NSArray<TagViewModel *> *filteredTags = [self.tags filteredArrayUsingPredicate:searchPredicate];
    TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithListedTags:filteredTags fromAllTags:self.tags.copy];
    [self updateViewModel:newViewModel];
}

- (void)updateViewModel:(TagsViewModel *)viewModel {
    self.viewModel = viewModel;
    [self.delegate interactor:self didUpdateViewModel:self.viewModel];
    
    // Store selected tags for later use
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray<Tag *> *selectedTags = [NSMutableArray array];
        for (TagViewModel *tagVM in viewModel.selectedViewModels) {
            [selectedTags addObject:tagVM.tag];
        }
        [self.storageService storeSelectedTags:selectedTags];
    });
}

@end

NS_ASSUME_NONNULL_END
