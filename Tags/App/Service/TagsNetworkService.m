//
//  TagsNetworkService.m
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsNetworkService.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsNetworkService ()

@property (nonatomic, strong, readwrite) Network *network;

@end

@implementation TagsNetworkService

- (instancetype)initWithNetwork:(Network *)network {
    self = [super init];
    if (self) {
        self.network = network;
    }
    return self;
}

- (void)tagsOnCompletion:(void (^)(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error))completion {
    
    NSString *urlString = @"https://gist.githubusercontent.com/jgritman/7f2e89d1937ba9d9fc678f4c9844cbf1/raw/7ed77d47fd7c87ad0e6aca697251ae3974452f37/tags.json";
    NSURL *tagsURL = [NSURL URLWithString:urlString];
    [self.network jsonRequestWithURL:tagsURL onCompletion:^(JSONArray * _Nullable jsonArray,
                                                            NSURLResponse * _Nullable response,
                                                            NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSMutableArray<Tag *> *tags = [NSMutableArray array];
        for (JSONObject *jsonObject in jsonArray) {
            Tag *tag = [[Tag alloc] initWithDictionary:jsonObject];
            if (tag) {
                [tags addObject:tag];
            }
        }
        
        completion(tags, nil);
        
    }];
}

@end

NS_ASSUME_NONNULL_END
