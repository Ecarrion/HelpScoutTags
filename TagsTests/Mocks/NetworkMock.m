//
//  NetworkMock.m
//  TagsTests
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "NetworkMock.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkMock ()

@property (nonatomic, strong, readwrite) NSURLSession *session;
@property (nonatomic, strong, readwrite) NSURL *requestedURL;

@end

@implementation NetworkMock

- (NSURLSessionTask *)requestWithURL:(NSURL *)url onCompletion:(void (^)(NSData * _Nullable data,
                                                                         NSURLResponse * _Nullable response,
                                                                         NSError * _Nullable error))completion {
    self.requestedURL = url;
    completion(self.dataMock, nil, self.errorMock);
    return nil;
}

- (NSURLSessionTask *)jsonRequestWithURL:(NSURL *)url onCompletion:(void (^)(JSONArray * _Nullable jsonArray,
                                                                             NSURLResponse * _Nullable response,
                                                                             NSError * _Nullable error))completion {
    self.requestedURL = url;
    completion(self.jsonMock, nil, self.errorMock);
    return nil;
}

@end

NS_ASSUME_NONNULL_END
