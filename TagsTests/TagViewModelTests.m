//
//  TagViewModelTests.m
//  TagsTests
//
//  Created by Ernesto Carrion on 12/21/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TagViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagViewModelTests : XCTestCase

@end

@implementation TagViewModelTests

- (void) testCorrectTagName {
    
    Tag *tag = [[Tag alloc] initWithID:@1 color:@"804181" name:@"My Tag"];
    TagViewModel *tagViewModel = [[TagViewModel alloc] initWithTag:tag isSelected:NO];
    XCTAssertEqual(tagViewModel.name, @"My Tag");
}

- (void) testCorrectBackgroundColor {
    
    Tag *tag = [[Tag alloc] initWithID:@1 color:@"804181" name:@"My Tag"];
    TagViewModel *tagViewModel = [[TagViewModel alloc] initWithTag:tag isSelected:NO];
    const CGFloat *components = CGColorGetComponents([[tagViewModel backgroundColor] CGColor]);
    
    //UIColor *expectedColor = [UIColor colorWithRed:128.0f/255.0f green:65.0f/255.0f blue:129.0f/255.0f alpha:1];
    XCTAssertTrue(components[0] == 128.0/255.0);
    XCTAssertTrue(components[1] == 65.0/255.0);
    XCTAssertTrue(components[2] == 129.0/255.0);
}

@end

NS_ASSUME_NONNULL_END
