//
//  TagsNetworkServiceTests.m
//  TagsTests
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkMock.h"
#import "TagsNetworkService.h"

@interface TagsNetworkServiceTests : XCTestCase

@property (nonatomic, strong) NetworkMock *network;
@property (nonatomic, strong) TagsNetworkService *sut;

@end

@implementation TagsNetworkServiceTests

- (void)setUp {
    [super setUp];
    
    self.network = [[NetworkMock alloc] init];
    self.sut = [[TagsNetworkService alloc] initWithNetwork:self.network];
}

- (void)testCorrectURLIsRequest {
    
    self.network.jsonMock = @[@{}];
    [self.sut tagsOnCompletion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
        // Empty
    }];
    
    NSString *urlString = @"https://gist.githubusercontent.com/jgritman/7f2e89d1937ba9d9fc678f4c9844cbf1/raw/7ed77d47fd7c87ad0e6aca697251ae3974452f37/tags.json";
    NSURL *correctURL = [NSURL URLWithString:urlString];
    XCTAssertEqualObjects(self.network.requestedURL, correctURL);
}

- (void)testTagsAreFetched {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectations"];
    self.network.jsonMock = @[@{@"id" : @1, @"color" : @"804181", @"tag" : @"knuckleball"},
                              @{@"id" : @2, @"color" : @"c6e627", @"tag" : @"ignoramus"}];
    
    [self.sut tagsOnCompletion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
    
        XCTAssertEqual(tags.count, 2);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout: 1.0 handler: nil];
}

- (void)testCorruptedTagsAreEvicted {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expectations"];
    self.network.jsonMock = @[@{@"id" : @1, @"color" : @"804181", @"tag" : @"knuckleball"},
                              @{@"color" : @"c6e627", @"tag" : @"ignoramus"}];
    
    [self.sut tagsOnCompletion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
        
        XCTAssertEqual(tags.count, 1);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout: 1.0 handler: nil];
    
}

@end
