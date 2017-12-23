//
//  TagCollectionCell.m
//  Tags
//
//  Created by Ernesto Carrion on 12/21/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagCollectionCell.h"

NSString *const TagCollectionCellID = @"TagCollectionCellIdentifier";

@implementation TagCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
}

-(void)prepareForReuse {
    self.nameLabel.text = @"";
    self.backgroundColor = UIColor.whiteColor;
}

@end
