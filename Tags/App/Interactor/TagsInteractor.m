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
@property (nonatomic, strong, readwrite) NSObject<TagsStorageType> *storageService;

@property (nonatomic, strong, readwrite) TagsViewModel *viewModel;
@property (nonatomic, strong, readwrite) NSMutableArray<TagViewModel *> *tags;

@end

@implementation TagsInteractor

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network andTagsService:(nonnull NSObject<TagsStorageType> *)storageService {
    self = [super init];
    if (self) {
        self.networkService = [[TagsNetworkService alloc] initWithNetwork: network];
        self.storageService = storageService;
    }
    return self;
}

- (void)requestTags {
    
    // Send a loading ViewModel
    TagsViewModel *tagsViewModel = [[TagsViewModel alloc] initWithListedTags:@[]
                                                                 fromAllTags:@[]
                                                                    andState:Loading];
    [self updateViewModel:tagsViewModel];
    
    __weak TagsInteractor *weakSelf = self;
    [self.networkService tagsOnCompletion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
        
        if (error) {
            TagsViewModel *tagsViewModel = [[TagsViewModel alloc] initWithListedTags:@[] fromAllTags:@[] andState:Error];
            [weakSelf updateViewModel:tagsViewModel];
            return;
        }
        
        // Load previous selected tags
        NSArray<Tag *> *selectedTags = [weakSelf.storageService loadSelectedTags];
        
        // Create new viewModels
        self.tags = [NSMutableArray array];
        for (Tag *tag in tags) {
            Boolean isSelected = [selectedTags containsObject:tag];
            TagViewModel *viewModel = [[TagViewModel alloc] initWithTag:tag isSelected:isSelected];
            [weakSelf.tags addObject:viewModel];
        }
        
        // Send the loaded ViewModel
        TagsViewModel *tagsViewModel = [[TagsViewModel alloc] initWithListedTags:weakSelf.tags.copy
                                                                     fromAllTags:weakSelf.tags.copy
                                                                        andState:Loaded];
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
    TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithListedTags:listedTags.copy
                                                                fromAllTags:self.tags.copy
                                                                   andState:Loaded];
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
        TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithListedTags:self.tags.copy
                                                                    fromAllTags:self.tags.copy
                                                                       andState:Loaded];
        [self updateViewModel:newViewModel];
        return;
    }
    
    NSPredicate * searchPredicate = [NSPredicate predicateWithBlock:^BOOL(TagViewModel *tagViewModel, NSDictionary<NSString *,id> *bindings) {
        return [tagViewModel.name localizedCaseInsensitiveContainsString:query];
    }];
    
    // Filter tags using a a case insensitive compare
    NSArray<TagViewModel *> *filteredTags = [self.tags filteredArrayUsingPredicate:searchPredicate];
    TagsViewModel *newViewModel = [[TagsViewModel alloc] initWithListedTags:filteredTags
                                                                fromAllTags:self.tags.copy
                                                                   andState:Loaded];
    [self updateViewModel:newViewModel];
}

- (void)updateViewModel:(TagsViewModel *)viewModel {
    self.viewModel = viewModel;
    [self.delegate interactor:self didUpdateViewModel:self.viewModel];
    
    // If there state is different than Loaded don't store the tags into disk
    if (viewModel.state != Loaded) {
        return;
    }
    
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
