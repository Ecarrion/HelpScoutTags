//
//  TagsViewController.m
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagsViewController.h"
#import "TagCollectionCell.h"
#import "TagsInteractor.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * CellIdentifier = @"TagCell";

@interface TagsViewController ()<UITableViewDelegate, UITableViewDataSource, TagsInteractorDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

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
    [self.collectionView registerNib:[UINib nibWithNibName:@"TagCollectionCell" bundle:nil] forCellWithReuseIdentifier:TagCollectionCellID];
}

#pragma mark - TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.interactor.viewModel.tagViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TagViewModel *tagViewModel = self.interactor.viewModel.tagViewModels[indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = tagViewModel.name;
    
    if (tagViewModel.isSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.interactor toggleTagSelectionAtIndex:indexPath.row];
}

#pragma mark - CollectionView Delegates

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.interactor.viewModel.selectedViewModels.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    static TagCollectionCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [[[UINib nibWithNibName:@"TagCollectionCell" bundle:nil] instantiateWithOwner:self options:nil] firstObject];
    });
    
    TagViewModel *tagViewModel = self.interactor.viewModel.selectedViewModels[indexPath.row];
    sizingCell.nameLabel.text = tagViewModel.name;
    sizingCell.backgroundColor = tagViewModel.backgroundColor;
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    return [sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagViewModel *tagViewModel = self.interactor.viewModel.selectedViewModels[indexPath.row];
    TagCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TagCollectionCellID forIndexPath:indexPath];
    cell.nameLabel.text = tagViewModel.name;
    cell.backgroundColor = tagViewModel.backgroundColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TagViewModel *tagViewModel = self.interactor.viewModel.selectedViewModels[indexPath.row];
    [self.interactor deselectTag:tagViewModel];
}

#pragma mark - Interactor Delegates

- (void)interactor:(TagsInteractor *)interactor didUpdateViewModel:(TagsViewModel *)viewModel {
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

@end

NS_ASSUME_NONNULL_END
