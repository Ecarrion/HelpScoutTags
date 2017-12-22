//
//  TagViewModel.m
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "TagViewModel.h"
#import "UIColor+Hex.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagViewModel ()

@property(nonatomic, strong, readwrite) Tag *tag;
@property(nonatomic, readwrite) Boolean isSelected;

@end

@implementation TagViewModel

- (instancetype)initWithTag:(Tag *)tag isSelected:(Boolean)isSelected {
    self = [super init];
    if (self) {
        self.tag = tag;
        self.isSelected = isSelected;
    }
    return self;
}

- (NSString *)name {
    return self.tag.name;
}

- (UIColor *)backgroundColor {
    return [UIColor colorFromHex: self.tag.color];
}

@end

NS_ASSUME_NONNULL_END
