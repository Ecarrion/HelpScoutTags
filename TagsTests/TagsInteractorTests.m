//
//  TagsInteractorTests.m
//  TagsTests
//
//  Created by Ernesto Carrion on 12/21/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TagsInteractor.h"
#import "NetworkMock.h"

NS_ASSUME_NONNULL_BEGIN

@interface InteractorDelegate: NSObject<TagsInteractorDelegate>

@property(nonatomic, strong, nullable) TagsViewModel *lastViewModel;

@end

@implementation InteractorDelegate

- (void)interactor:(TagsInteractor *)interactor didUpdateViewModel:(TagsViewModel *)viewModel {
    self.lastViewModel = viewModel;
}

@end


@interface TagsInteractorTests : XCTestCase

@property (nonatomic, strong) TagsInteractor *sut;
@property (nonatomic, strong) InteractorDelegate *delegate;

@end

@implementation TagsInteractorTests

- (void)setUp {
    [super setUp];
    
    NetworkMock *network = [[NetworkMock alloc] init];
    network.jsonMock = @[@{@"id" : @1, @"color" : @"804181", @"tag" : @"knuckleball"},
                         @{@"id" : @2, @"color" : @"c6e627", @"tag" : @"ignoramus"},
                         @{@"id" : @3, @"color" : @"804181", @"tag" : @"birder"},
                         @{@"id" : @4, @"color" : @"c6e627", @"tag" : @"scandal"},
                         @{@"id" : @5, @"color" : @"804181", @"tag" : @"stew"},
                         @{@"id" : @6, @"color" : @"c6e627", @"tag" : @"arnica_bud"},
                         @{@"id" : @7, @"color" : @"804181", @"tag" : @"tobacco_mosaic"},
                         @{@"id" : @8, @"color" : @"c6e627", @"tag" : @"6fb8ce"}];
    
    self.sut = [[TagsInteractor alloc] initWithNetwork:network];
    self.delegate = [[InteractorDelegate alloc] init];
    self.sut.delegate = self.delegate;
    [self.sut requestTags];
}

- (void)testViewModelContainsAllTagsAndHaveNoSelected {
    XCTAssertNotNil(self.delegate.lastViewModel.tagViewModels);
    XCTAssertEqual(self.delegate.lastViewModel.tagViewModels.count, 8);
    XCTAssertEqual(self.delegate.lastViewModel.selectedViewModels.count, 0);
}

- (void)testSelectingTags {
    [self.sut toggleTagSelectionAtIndex:1];
    [self.sut toggleTagSelectionAtIndex:2];
    XCTAssertEqual(self.delegate.lastViewModel.selectedViewModels.count, 2);
    XCTAssertEqual(self.delegate.lastViewModel.selectedViewModels[0].tag.tagID, @3);
    XCTAssertEqual(self.delegate.lastViewModel.selectedViewModels[1].tag.tagID, @2);
}

- (void)testUnselectingTags {
    [self.sut toggleTagSelectionAtIndex:1];
    [self.sut toggleTagSelectionAtIndex:2];
    [self.sut toggleTagSelectionAtIndex:1];
    XCTAssertEqual(self.delegate.lastViewModel.selectedViewModels.count, 1);
    XCTAssertEqual(self.delegate.lastViewModel.selectedViewModels[0].tag.tagID, @3);
}

@end

NS_ASSUME_NONNULL_END
