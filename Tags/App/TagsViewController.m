//
//  TagsViewController.m
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsViewController.h"
#import "TagsNetworkService.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TagsNetworkService *service;

@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Network *network = [[Network alloc] initWithSession:NSURLSession.sharedSession];
    self.service = [[TagsNetworkService alloc] initWithNetwork:network];
    [self.service tagsOnCompletion:^(NSArray<Tag *> * _Nullable tags, NSError * _Nullable error) {
        for (Tag *tag in tags) {
            NSLog(@"%@", tag.name);
        }
    }];
}

@end

NS_ASSUME_NONNULL_END
