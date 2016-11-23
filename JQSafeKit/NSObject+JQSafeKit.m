//
//  NSObject+JQSafeKit.m
//  JQSafeKitDemo
//
//  Created by lei on 2016/11/23.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import "NSObject+JQSafeKit.h"
#import "JQSafeKit.h"
@implementation NSObject (JQSafeKit)
+ (void)JQSafeKitExchangeMethod {
    
    //setValue:forKey:
    [JQSafeKit exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKey:) method2Sel:@selector(JQSafeKitSetValue:forKey:)];
    
    //setValue:forKeyPath:
    [JQSafeKit exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKeyPath:) method2Sel:@selector(JQSafeKitSetValue:forKeyPath:)];
    
    //setValue:forUndefinedKey:
    [JQSafeKit exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forUndefinedKey:) method2Sel:@selector(JQSafeKitSetValue:forUndefinedKey:)];
    
    //setValuesForKeysWithDictionary:
    [JQSafeKit exchangeInstanceMethod:[self class] method1Sel:@selector(setValuesForKeysWithDictionary:) method2Sel:@selector(JQSafeKitSetValuesForKeysWithDictionary:)];
}



//=================================================================
//                         setValue:forKey:
//=================================================================
#pragma mark - setValue:forKey:

- (void)JQSafeKitSetValue:(id)value forKey:(NSString *)key {
    @try {
        [self JQSafeKitSetValue:value forKey:key];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = JQSafeKitDefaultIgnore;
        [JQSafeKit noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}


//=================================================================
//                     setValue:forKeyPath:
//=================================================================
#pragma mark - setValue:forKeyPath:

- (void)JQSafeKitSetValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self JQSafeKitSetValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = JQSafeKitDefaultIgnore;
        [JQSafeKit noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}



//=================================================================
//                     setValue:forUndefinedKey:
//=================================================================
#pragma mark - setValue:forUndefinedKey:

- (void)JQSafeKitSetValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self JQSafeKitSetValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = JQSafeKitDefaultIgnore;
        [JQSafeKit noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}


//=================================================================
//                  setValuesForKeysWithDictionary:
//=================================================================
#pragma mark - setValuesForKeysWithDictionary:

- (void)JQSafeKitSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    @try {
        [self JQSafeKitSetValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = JQSafeKitDefaultIgnore;
        [JQSafeKit noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

@end
