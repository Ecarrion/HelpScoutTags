//
//  TagViewModel.h
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Tag.h"

@interface TagViewModel : NSObject

@property(nonatomic, strong, readonly) Tag *tag;
@property(nonatomic, readonly) Boolean isSelected;

- (instancetype)initWitnTag:(Tag *)tag isSelected:(Boolean)isSelected;
- (NSString *)name;
- (UIColor *)backgroundColor;

@end
