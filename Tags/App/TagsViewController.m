//
//  TagsViewController.m
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsViewController.h"
#import "TagsInteractor.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TagsInteractor *interactor;

@end

@implementation TagsViewController

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network {
    self = [super init];
    if (self) {
        self.interactor = [[TagsInteractor alloc] initWithNetwork: network];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end

NS_ASSUME_NONNULL_END
