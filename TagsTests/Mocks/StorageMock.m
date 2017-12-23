//
//  StorageMock.m
//  TagsTests
//
//  Created by Ernesto Carrion on 12/23/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "StorageMock.h"

@implementation StorageMock

-(void)storeSelectedTags:(NSArray<Tag *> *)tags {
    // Do nothing
}

- (NSArray<Tag *> *)loadSelectedTags {
    return self.tagsMock;
}

@end
