//
//  NSAttributedString+JQSafeKit.m
//  JQSafeKitDemo
//
//  Created by lei on 2016/11/23.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import "NSAttributedString+JQSafeKit.h"
#import "JQSafeKit.h"
@implementation NSAttributedString (JQSafeKit)
+ (void)JQSafeKitExchangeMethod {
    
    Class NSConcreteAttributedString = NSClassFromString(@"NSConcreteAttributedString");
    
    //initWithString:
    [JQSafeKit exchangeInstanceMethod:NSConcreteAttributedString method1Sel:@selector(initWithString:) method2Sel:@selector(JQSafeKitInitWithString:)];
    
    //initWithAttributedString
    [JQSafeKit exchangeInstanceMethod:NSConcreteAttributedString method1Sel:@selector(initWithAttributedString:) method2Sel:@selector(JQSafeKitInitWithAttributedString:)];
    
    //initWithString:attributes:
    [JQSafeKit exchangeInstanceMethod:NSConcreteAttributedString method1Sel:@selector(initWithString:attributes:) method2Sel:@selector(JQSafeKitInitWithString:attributes:)];
    
}

//=================================================================
//                           initWithString:
//=================================================================
#pragma mark - initWithString:

- (instancetype)JQSafeKitInitWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self JQSafeKitInitWithString:str];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = JQSafeKitDefaultReturnNil;
        [JQSafeKit noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                          initWithAttributedString
//=================================================================
#pragma mark - initWithAttributedString

- (instancetype)JQSafeKitInitWithAttributedString:(NSAttributedString *)attrStr {
    id object = nil;
    
    @try {
        object = [self JQSafeKitInitWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = JQSafeKitDefaultReturnNil;
        [JQSafeKit noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                      initWithString:attributes:
//=================================================================
#pragma mark - initWithString:attributes:

- (instancetype)JQSafeKitInitWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self JQSafeKitInitWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = JQSafeKitDefaultReturnNil;
        [JQSafeKit noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}
@end

