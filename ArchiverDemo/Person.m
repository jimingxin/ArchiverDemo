//
//  Person.m
//  ArchiverDemo
//
//  Created by 嵇明新 on 2017/2/23.
//  Copyright © 2017年 lanhe. All rights reserved.
//

#import "Person.h"

@implementation Person

-(instancetype) initWithName:(NSString *) name{

    if ([super init]) {
        self.name = name;
    }
    return self;
}

#pragma -mark将对象转化为NSData的方法
-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if ([self init]) {
        //解压过程
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [[aDecoder decodeObjectForKey:@"age"] intValue];
    }
    return self;
}

- (instancetype) copyWithZone:(NSZone *) zone{
    Person *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [self.name copyWithZone:zone];
    copy.age = self.age;
    return copy;
}

@end
