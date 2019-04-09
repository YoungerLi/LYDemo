//
//  CopyModel.m
//  LYDemo
//
//  Created by liyang on 2018/1/16.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "CopyModel.h"

@implementation CopyModel

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeObjectForKey:@"age"];
    }
    return self;
}




#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    CopyModel *model = [[[self class] allocWithZone:zone] init];
    model.name = self.name;
    model.age = self.age;
    return model;
}




#pragma mark - description

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@", self.name, self.age];
}

@end
