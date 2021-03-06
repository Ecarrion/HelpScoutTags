//
//  TagsViewModel.m
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsViewModel ()

@property (nonatomic, strong, readwrite) NSArray<TagViewModel *> *tagViewModels;
@property (nonatomic, strong, readwrite) NSArray<TagViewModel *> *selectedViewModels;
@property (nonatomic, readwrite) State state;

@end

@implementation TagsViewModel

- (instancetype)initWithListedTags:(NSArray<TagViewModel *> *)listedTags
                       fromAllTags:(NSArray<TagViewModel *> *)allTags
                          andState:(State)state {

    self = [super init];
    if (self) {
        self.tagViewModels = listedTags;
        self.selectedViewModels = [self selectedAndSortedArrayFrom:allTags];
        self.state = state;
    }
    return self;
}

- (NSArray<TagViewModel *> *)selectedAndSortedArrayFrom:(NSArray<TagViewModel *> *)viewModels {
    
    // Filter selected ViewModels
    NSPredicate *filterPredicate = [NSPredicate predicateWithBlock:^BOOL(TagViewModel *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject.isSelected;
    }];
    NSArray<TagViewModel *> *filtered = [viewModels filteredArrayUsingPredicate:filterPredicate];
    
    // Sort filtered ViewModels alphabetically
    return [filtered sortedArrayUsingComparator:^NSComparisonResult(TagViewModel *obj1, TagViewModel *obj2) {
        return [obj1.name compare:obj2.name] == NSOrderedDescending;
    }];
}

@end

NS_ASSUME_NONNULL_END
