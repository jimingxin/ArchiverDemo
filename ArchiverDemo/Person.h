//
//  Person.h
//  ArchiverDemo
//
//  Created by 嵇明新 on 2017/2/23.
//  Copyright © 2017年 lanhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>


@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int age;

-(instancetype) initWithName:(NSString *) name;

@end
