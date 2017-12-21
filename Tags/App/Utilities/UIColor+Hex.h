//
//  UIColor+Hex.h
//  Tags
//
//  Created by Ernesto Carrion on 12/20/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)

+ (UIColor *)colorFromHex:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
