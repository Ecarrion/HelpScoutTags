//
//  TagsStorageService.m
//  Tags
//
//  Created by Ernesto Carrion on 12/23/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsStorageService.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TagsStorageService

+ (NSString *)selectedTagsPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    return [cacheDirectory stringByAppendingPathComponent:@"selected-tags.archive"];
}

- (void)storeSelectedTags:(NSArray<Tag *> *)tags {
    [NSKeyedArchiver archiveRootObject:tags toFile:[TagsStorageService selectedTagsPath]];
}

- (NSArray<Tag *> *)loadSelectedTags {
    
    NSArray<Tag *> *tags = [NSKeyedUnarchiver unarchiveObjectWithFile:[TagsStorageService selectedTagsPath]];
    if (tags == nil) {
        tags = @[];
    }
    
    return tags;
}

@end

NS_ASSUME_NONNULL_END
