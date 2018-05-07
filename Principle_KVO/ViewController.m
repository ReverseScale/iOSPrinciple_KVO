//
//  ViewController.m
//  Principle_KVO
//
//  Created by WhatsXie on 2018/5/7.
//  Copyright © 2018年 WhatsXie. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test_kvo];
    
    [self test_kvo_manually];
}

// Example kvo
- (void)test_kvo {
    Person *p1 = [[Person alloc] init];
    Person *p2 = [[Person alloc] init];
    p1.age = 1;
    p2.age = 2;
    
    [self methodForSelectorLogWithP1:p1 P2:p2];
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [p1 addObserver:self forKeyPath:@"age" options:options context:nil];
    
    NSLog(@"print class: %@,%@",[p1 class],[p2 class]);
    
    [self methodForSelectorLogWithP1:p1 P2:p2];
    
    p1.age = 10;
    
    [self printMethods: object_getClass(p2)];
    [self printMethods: object_getClass(p1)];
    
    [p1 removeObserver:self forKeyPath:@"age"];
}
// Example kvo by manual
- (void)test_kvo_manually {
    Person *p1 = [[Person alloc] init];
    p1.age = 1.0;
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [p1 addObserver:self forKeyPath:@"age" options:options context:nil];
    
    [p1 willChangeValueForKey:@"age"];
    [p1 didChangeValueForKey:@"age"];
    
    [p1 removeObserver:self forKeyPath:@"age"];
}

// kvo action
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到%@的%@改变了%@", object, keyPath,change);
}

// kvo func to show working
- (void)methodForSelectorLogWithP1:(NSObject *)p1 P2:(NSObject *)p2 {
    NSLog(@"添加KVO监听之前 - p1 = %p, p2 = %p", [p1 methodForSelector: @selector(setAge:)],[p2 methodForSelector: @selector(setAge:)]);
}

// runtime to print class methods
- (void)printMethods:(Class)cls {
    unsigned int count ;
    Method *methods = class_copyMethodList(cls, &count);
    NSMutableString *methodNames = [NSMutableString string];
    [methodNames appendFormat:@"%@ method list: ", cls];
    for (int i = 0 ; i < count; i++) {
        Method method = methods[i];
        NSString *methodName  = NSStringFromSelector(method_getName(method));
        
        [methodNames appendString:@"\n"];
        [methodNames appendString: methodName];
    }
    NSLog(@"%@",methodNames);
    free(methods);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
