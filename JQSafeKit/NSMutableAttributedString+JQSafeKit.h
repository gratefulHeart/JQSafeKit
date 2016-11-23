//
//  NSMutableAttributedString+JQSafeKit.h
//  JQSafeKitDemo
//
//  Created by lei on 2016/11/23.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (JQSafeKit)
/**
 *  使用这些方式避免崩溃
 *
 *  1.- (instancetype)initWithString:(NSString *)str
 *  2.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs
 */
+ (void)JQSafeKitExchangeMethod;
@end
