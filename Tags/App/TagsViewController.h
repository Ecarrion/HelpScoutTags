//
//  TagsViewController.h
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsInteractor.h"
#import "Network.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsViewController : UIViewController

- (instancetype)initWithInteractor:(TagsInteractor *)interactor;

@end

NS_ASSUME_NONNULL_END
