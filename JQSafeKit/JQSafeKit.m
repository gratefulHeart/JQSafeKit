//
//  JQSafeKit.m
//  JQSafeKit
//
//  Created by HaRi on 2016/10/23.
//  Copyright © 2016年 HaRi. All rights reserved.
//

#import "JQSafeKit.h"

// category
#import "NSArray+JQSafeKit.h"
#import "NSString+JQSafeKit.h"
#import "NSAttributedString+JQSafeKit.h"
#import "NSDictionary+JQSafeKit.h"

#import "NSMutableArray+JQSafeKit.h"
#import "NSMutableString+JQSafeKit.h"
#import "NSMutableDictionary+JQSafeKit.h"
#import "NSMutableAttributedString+JQSafeKit.h"
#import "NSObject+JQSafeKit.h"

#define JQSafeKitSeparator         @"======================================================"
#define JQSafeKitSeparatorWithFlag @"===================JQSafeKit Log====================="

#define key_errorName        @"errorName"
#define key_errorReason      @"errorReason"
#define key_errorPlace       @"errorPlace"
#define key_defaultToDo      @"defaultToDo"
#define key_callStackSymbols @"callStackSymbols"
#define key_exception        @"exception"

@implementation JQSafeKit

/**
 *  开始生效(进行方法的交换)
 */
+ (void)becomeEffective {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [NSArray JQSafeKitExchangeMethod];
        [NSMutableArray JQSafeKitExchangeMethod];
        
        [NSDictionary JQSafeKitExchangeMethod];
        [NSMutableDictionary JQSafeKitExchangeMethod];
        
        [NSString JQSafeKitExchangeMethod];
        [NSMutableString JQSafeKitExchangeMethod];
        
        [NSAttributedString JQSafeKitExchangeMethod];
        [NSMutableAttributedString JQSafeKitExchangeMethod];
        
        [NSObject JQSafeKitExchangeMethod];
    });
}

/**
 *  类方法的交换
 *
 *  @param anClass    哪个类
 *  @param method1Sel 方法1
 *  @param method2Sel 方法2
 */
+ (void)exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    Method method1 = class_getClassMethod(anClass, method1Sel);
    Method method2 = class_getClassMethod(anClass, method2Sel);
    method_exchangeImplementations(method1, method2);
}


/**
 *  对象方法的交换
 *
 *  @param anClass    哪个类
 *  @param method1Sel 方法1
 *  @param method2Sel 方法2
 */
+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel {
    Method method1 = class_getInstanceMethod(anClass, method1Sel);
    Method method2 = class_getInstanceMethod(anClass, method2Sel);
    method_exchangeImplementations(method1, method2);
}



/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbolStr 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbolStr:(NSString *)callStackSymbolStr {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    [regularExp enumerateMatchesInString:callStackSymbolStr options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbolStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            mainCallStackSymbolMsg = [callStackSymbolStr substringWithRange:result.range];
            *stop = YES;
        }
    }];
    
    
    
    return mainCallStackSymbolMsg;
}


/**
 *  提示崩溃的信息(控制台输出、通知)
 *
 *  @param exception   捕获到的异常
 *  @param defaultToDo 这个框架里默认的做法
 */
+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo {

    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [JQSafeKit getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    if (mainCallStackSymbolMsg == nil) {
        
        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
        
    }
    
    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    //errorReason 可能为 -[__NSCFConstantString JQSafeKitCharacterAtIndex:]: Range or index out of bounds
    //将JQSafeKit去掉
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"JQSafeKit" withString:@""];
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@\n\n%@\n\n",JQSafeKitSeparatorWithFlag, errorName, errorReason, errorPlace, defaultToDo, JQSafeKitSeparator];
    NSLog(@"%@", logErrorMessage);
    
    NSDictionary *errorInfoDic = @{
                                   key_errorName        : errorName,
                                   key_errorReason      : errorReason,
                                   key_errorPlace       : errorPlace,
                                   key_defaultToDo      : defaultToDo,
                                   key_exception        : exception,
                                   key_callStackSymbols : callStackSymbolsArr
                                   };
    
    //将错误信息放在字典里，用通知的形式发送出去
    [[NSNotificationCenter defaultCenter] postNotificationName:JQSafeKitNotification object:nil userInfo:errorInfoDic];
}

@end
