//
//  UIColor+Hex.m
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "UIColor+Hex.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIColor (Hex)

+ (UIColor *)colorFromHex:(NSString *)hexString {
    
    NSInteger hex = hexString.integerValue;
    NSInteger r = (hex >> 16) & 0xFF;
    NSInteger g = (hex >> 8) & 0xFF;
    NSInteger b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

@end

NS_ASSUME_NONNULL_END
