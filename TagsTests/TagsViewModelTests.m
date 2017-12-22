//
//  TagsViewModelTests.m
//  TagsTests
//
//  Created by Ernesto Carrion on 12/21/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TagsViewModel.h"

@interface TagsViewModelTests : XCTestCase

@end

@implementation TagsViewModelTests

- (void)testSelectedAndSortedViewModels {
    
    Tag *tag1 = [[Tag alloc] initWithID:@1 color:@"804181" name:@"aaa"];
    Tag *tag2 = [[Tag alloc] initWithID:@2 color:@"804181" name:@"ddd"];
    Tag *tag3 = [[Tag alloc] initWithID:@3 color:@"804181" name:@"ccc"];
    Tag *tag4 = [[Tag alloc] initWithID:@4 color:@"804181" name:@"bbb"];
    
    TagViewModel *tagVM1 = [[TagViewModel alloc] initWithTag:tag1 isSelected:NO];
    TagViewModel *tagVM2 = [[TagViewModel alloc] initWithTag:tag2 isSelected:YES];
    TagViewModel *tagVM3 = [[TagViewModel alloc] initWithTag:tag3 isSelected:YES];
    TagViewModel *tagVM4 = [[TagViewModel alloc] initWithTag:tag4 isSelected:NO];
    
    TagsViewModel *tagsViewModel = [[TagsViewModel alloc] initWithTags:@[tagVM1, tagVM2, tagVM3, tagVM4]];
    NSArray<TagViewModel *> *expectedArray = @[tagVM3, tagVM2]; // Filter notSelected and sort them by name
    XCTAssertEqualObjects(tagsViewModel.selectedViewModels, expectedArray);
}

@end
