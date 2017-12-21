//
//  NetworkMock.h
//  TagsTests
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Network.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkMock : NSObject<NetworkType>

/// Captured URL from the request
@property (nonatomic, strong, readonly) NSURL *requestedURL;

/// Provide a value to be returned when invoke a requestData method
@property (nonatomic, strong, nullable) NSData *dataMock;

/// Provide a value to be returned when invoke a requestJson method
@property (nonatomic, strong, nullable) JSONArray *jsonMock;

/// Provide a value to be returned when invoke any request method
@property (nonatomic, strong, nullable) NSError *errorMock;

@end

NS_ASSUME_NONNULL_END
