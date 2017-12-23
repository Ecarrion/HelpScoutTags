//
//  TagsStorageService.h
//  Tags
//
//  Created by Ernesto Carrion on 12/23/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TagsStorageType

- (void)storeSelectedTags:(NSArray<Tag *> *)tags;
- (NSArray<Tag *> *)loadSelectedTags;

@end

@interface TagsStorageService : NSObject <TagsStorageType>

@end

NS_ASSUME_NONNULL_END
