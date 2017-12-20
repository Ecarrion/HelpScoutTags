//
//  Tag.h
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tag : NSObject

@property(nonatomic, strong, readonly) NSNumber *tagID;
@property(nonatomic, strong, readonly) NSString *color;
@property(nonatomic, strong, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END
