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
    NSString *hex = [NSString stringWithFormat:@"#%@", hexString];
    int red = 0;
    int green = 0;
    int blue = 0;
    sscanf([hex UTF8String], "#%02X%02X%02X", &red, &green, &blue);
    return  [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

@end

NS_ASSUME_NONNULL_END
