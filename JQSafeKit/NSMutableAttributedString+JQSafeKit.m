//
//  NSMutableAttributedString+JQSafeKit.m
//  JQSafeKitDemo
//
//  Created by lei on 2016/11/23.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import "NSMutableAttributedString+JQSafeKit.h"
#import "JQSafeKit.h"
@implementation NSMutableAttributedString (JQSafeKit)
+ (void)JQSafeKitExchangeMethod {
    
    Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
    
    //initWithString:
    [JQSafeKit exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:) method2Sel:@selector(JQSafeKitInitWithString:)];
    
    //initWithString:attributes:
    [JQSafeKit exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:attributes:) method2Sel:@selector(JQSafeKitInitWithString:attributes:)];
}

//=================================================================
//                          initWithString:
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
//                     initWithString:attributes:
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

