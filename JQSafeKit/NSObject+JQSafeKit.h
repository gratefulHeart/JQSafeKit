//
//  NSObject+JQSafeKit.h
//  JQSafeKitDemo
//
//  Created by lei on 2016/11/23.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JQSafeKit)
/**
 *  KVC
 *
 *  1.- (void)setValue:(id)value forKey:(NSString *)key
 *  2.- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
 *  3.- (void)setValue:(id)value forUndefinedKey:(NSString *)key //这个方法一般用来重写，不会主动调用
 *  4.- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
 *
 */

+ (void)JQSafeKitExchangeMethod;
@end
