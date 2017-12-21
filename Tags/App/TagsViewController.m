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

static NSString * CellIdentifier = @"TagCell";

@interface TagsViewController ()<UITableViewDelegate, UITableViewDataSource, TagsInteractorDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TagsInteractor *interactor;

@end

@implementation TagsViewController

- (instancetype)initWithNetwork:(NSObject<NetworkType> *)network {
    self = [super init];
    if (self) {
        self.interactor = [[TagsInteractor alloc] initWithNetwork: network];
        self.interactor.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCellClass];
    [self.interactor requestTags];
}

- (void)registerCellClass {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.interactor.viewModel.tagViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TagViewModel *tagViewModel = self.interactor.viewModel.tagViewModels[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = tagViewModel.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected");
}

#pragma mark - Interactor Delegates

- (void)interactor:(TagsInteractor *)interactor didUpdateViewModel:(TagsViewModel *)viewModel {
    [self.tableView reloadData];
}

@end

NS_ASSUME_NONNULL_END
