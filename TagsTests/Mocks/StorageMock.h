//
//  StorageMock.h
//  TagsTests
//
//  Created by Ernesto Carrion on 12/23/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagsStorageService.h"

@interface StorageMock : NSObject<TagsStorageType>

// Assign this property to return some tags when calling loadTags method
@property (nonatomic, strong) NSArray<Tag *> *tagsMock;

@end
