//
//  Network.h
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NetworkType

@property (readonly) NSURLSession *session;

typedef NSDictionary<NSString *, id> JSONObject;
typedef NSArray<JSONObject *> JSONArray;

- (NSURLSessionTask *)requestWithURL:(NSURL *)url onCompletion:(void (^)(NSData * _Nullable data,
                                                                         NSURLResponse * _Nullable response,
                                                                         NSError * _Nullable error))completion;

- (NSURLSessionTask *)jsonRequestWithURL:(NSURL *)url onCompletion:(void (^)(JSONArray * _Nullable jsonArray,
                                                                             NSURLResponse * _Nullable response,
                                                                             NSError * _Nullable error))completion;
@end

@interface Network : NSObject<NetworkType>

@property (nonatomic, strong, readonly) NSURLSession *session;

- (instancetype)initWithSession:(NSURLSession *)session;

@end

NS_ASSUME_NONNULL_END
