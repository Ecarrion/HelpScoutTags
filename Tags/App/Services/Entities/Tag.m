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

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.tagID = [aDecoder decodeObjectForKey:@"tagID"];
    self.color = [aDecoder decodeObjectForKey:@"tagColor"];
    self.name = [aDecoder decodeObjectForKey:@"tagName"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.tagID forKey:@"tagID"];
    [aCoder encodeObject:self.color forKey:@"tagColor"];
    [aCoder encodeObject:self.name forKey:@"tagName"];
}

- (BOOL)isEqual:(Tag *)other {
    if (other == self) {
        return YES;
    }
    
    return [self.tagID isEqual:other.tagID] && [self.name isEqual:other.name] && [self.color isEqual:other.color];
}

@end

NS_ASSUME_NONNULL_END
