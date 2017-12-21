//
//  Network.m
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "Network.h"

NS_ASSUME_NONNULL_BEGIN

@interface Network ()

@property (nonatomic, strong, readwrite) NSURLSession *session;

@end


@implementation Network

- (instancetype)initWithSession:(NSURLSession *)session {
    self = [super init];
    if (self) {
        self.session = session;
    }
    return self;
}

- (NSURLSessionTask *)requestWithURL:(NSURL *)url onCompletion:(void (^)(NSData * _Nullable data,
                                                                         NSURLResponse * _Nullable response,
                                                                         NSError * _Nullable error))completion {
    
    NSURLSessionTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data,
                                                                                   NSURLResponse * _Nullable response,
                                                                                   NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(data, response, error);
        });
    }];
    [task resume];
    
    return task;
}

- (NSURLSessionTask *)jsonRequestWithURL:(NSURL *)url onCompletion:(void (^)(JSONArray * _Nullable jsonArray,
                                                                             NSURLResponse * _Nullable response,
                                                                             NSError * _Nullable error))completion {
    
    return [self requestWithURL:url onCompletion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSError *jsonError;
        JSONArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        completion(jsonArray, response, error);
    }];
}

@end

NS_ASSUME_NONNULL_END
