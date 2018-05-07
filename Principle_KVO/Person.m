//
//  Person.m
//  Principle_KVO
//
//  Created by WhatsXie on 2018/5/7.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)setAge:(int)age {
    NSLog(@"setAge:");
    _age = age;
}

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"willChangeValueForKey: - begin");
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey: - end");
}
- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"didChangeValueForKey: - begin");
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey: - end");
}

@end
