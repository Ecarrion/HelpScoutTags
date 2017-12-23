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

@interface TagsViewController ()<UITableViewDelegate, UITableViewDataSource, TagsInteractorDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;


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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self adjustCollectionViewHeight];
    });
}

- (void)adjustCollectionViewHeight {
    
    CGFloat height = 0;
    CGFloat sectionInsets = 20;
    CGFloat contentSizeHeight = self.collectionView.contentSize.height;
    CGFloat quarterOfScreen = CGRectGetHeight(self.view.frame) / 4.0;
    
    if (contentSizeHeight != sectionInsets) {
        height = MIN(contentSizeHeight, quarterOfScreen);
    }
    
    self.collectionViewHeightConstraint.constant = height;
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
    TagViewModel *tagViewModel = self.interactor.viewModel.tagViewModels[indexPath.row];
    [self.interactor toggleSelectionOfTag:tagViewModel];
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

#pragma mark - Search Bar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.interactor filtertTagsByQuery:searchText];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

#pragma mark - Interactor Delegates

- (void)interactor:(TagsInteractor *)interactor didUpdateViewModel:(TagsViewModel *)viewModel {
    [self.tableView reloadData];
    [self.collectionView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self adjustCollectionViewHeight];
    });
}

@end

NS_ASSUME_NONNULL_END
