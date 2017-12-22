//
//  TagCollectionCell.h
//  Tags
//
//  Created by Ernesto Carrion on 12/21/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const TagCollectionCellID;

@interface TagCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
