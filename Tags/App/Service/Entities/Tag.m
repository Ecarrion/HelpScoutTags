//
//  Tag.m
//  Tags
//
//  Created by Ernesto Carrion on 12/19/17.
//  Copyright © 2017 HelpScout. All rights reserved.
//

#import "Tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tag ()

@property(nonatomic, strong, readwrite) NSNumber *tagID;
@property(nonatomic, strong, readwrite) NSString *color;
@property(nonatomic, strong, readwrite) NSString *name;

@end

@implementation Tag

- (instancetype)initWithID:(NSNumber *)tagID color:(NSString *)color name:(NSString *)name  {
    self = [super init];
    if (self) {
        self.tagID = tagID;
        self.color = color;
        self.name = name;
    }
    return self;
}

- (nullable instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary {
    
    NSNumber *tagID = dictionary[@"id"];
    NSString *color = dictionary[@"color"];
    NSString *name = dictionary[@"tag"];
    
    if (tagID == nil || !color || !name) {
        return nil;
    }
    
    return [self initWithID:tagID color:color name:name];
}

@end

NS_ASSUME_NONNULL_END
