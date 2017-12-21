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

@end

@implementation TagsViewModel

- (instancetype)initWithTags:(NSArray<TagViewModel *> *)tagViewModels {
    self = [super init];
    if (self) {
        self.tagViewModels = tagViewModels;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
