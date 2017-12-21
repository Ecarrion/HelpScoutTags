//
//  TagsInteractor.m
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsInteractor ()

@property (nonatomic, strong, readwrite) TagsNetworkService *networkService;

@end

@implementation TagsInteractor

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network {
    self = [super init];
    if (self) {
        self.networkService = [[TagsNetworkService alloc] initWithNetwork: network];
    }
    return self;
}

- (void)requestTags {
    
    __weak TagsInteractor *weakSelf = self;
    [self.networkService tagsOnCompletion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
        
        if (error) {
            // TODO: handle error in view model
            return;
        }
        
        NSMutableArray *viewModels = [NSMutableArray array];
        for (Tag *tag in tags) {
            TagViewModel *viewModel = [[TagViewModel alloc] initWitnTag: tag isSelected: false];
            [viewModels addObject:viewModel];
        }
        
        TagsViewModel *tagsViewModel = [[TagsViewModel alloc] initWithTags: viewModels.copy];
        [weakSelf.delegate interactor:weakSelf didUpdateViewModel:tagsViewModel];
    }];
}

@end

NS_ASSUME_NONNULL_END
