# JQSafeKit

[![CircleCI](https://img.shields.io/circleci/project/github/RedSparr0w/node-csgo-parser.svg)](https://github.com/XiaoHanGe/JQSafeKit)
[![Version](https://img.shields.io/cocoapods/v/JQSafeKit.svg?style=flat)](http://cocoapods.org/pods/JQSafeKit)
[![Coveralls branch](https://img.shields.io/coveralls/jekyll/jekyll/master.svg)](https://github.com/XiaoHanGe/JQSafeKit)
[![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)](https://github.com/XiaoHanGe/JQSafeKit)
[![Platform](https://img.shields.io/badge/platform-ios-brightgreen.svg)](http://cocoapods.org/pods/JQSafeKit)
[![Apps Using](https://img.shields.io/badge/Apps%20Using-%3E%20100-blue.svg)](https://github.com/XiaoHanGe/JQSafeKit)
[![CocoaPods](https://img.shields.io/cocoapods/dm/JQSafeKit.svg)](http://cocoapods.org/pods/JQSafeKit)

前言
===
一个已经发布到AppStore上的App，最忌讳的就是崩溃问题。为什么在开发阶段或者测试阶段都不会崩溃，而发布到AppStore上就崩溃了呢？究其根源，最主要的原因就是数据的错乱。特别是 服务器返回数据的错乱，将严重影响到我们的App。


---
Foundation框架存在许多潜在崩溃的危险
===
- 将 nil 插入可变数组中会导致崩溃。
- 数组越界会导致崩溃。
- 根据key给字典某个元素重新赋值时，若key为 nil 会导致崩溃。
- ......

---

JQSafeKit简介
===
- 这个框架利用runtime技术对一些常用并且容易导致崩溃的方法进行处理，可以有效的防止崩溃。
- 并且打印出具体是哪一行代码会导致崩溃，让你快速定位导致崩溃的代码。
- 你可以获取到原本导致崩溃的主要信息<由于这个框架的存在，并不会崩溃>，进行相应的处理。比如：
- 你可以将这些崩溃信息发送到自己服务器。
- 你若集成了第三方崩溃日志收集的SDK,比如你用了腾讯的Bugly,你可以上报自定义异常。


---
下面先来看下防止崩溃的效果吧
===

`可导致崩溃的代码`
```
NSString *nilStr = nil;
    NSArray *array = @[@"HaRi", nilStr];
```

- 若没有JQSafeKit来防止崩溃，则会直接崩溃，如下图

![崩溃截图.png](https://github.com/XiaoHanGe/JQSafeKit/blob/master/JQSafeKitDemo/%E6%88%AA%E5%9B%BE/1.png?raw=true)


- 若有JQSafeKit来防止崩溃，则不会崩溃，并且会将原本会崩溃情况的详细信息打印出来，如下图

![防止崩溃输出日志.png](https://github.com/XiaoHanGe/JQSafeKit/blob/master/JQSafeKitDemo/%E6%88%AA%E5%9B%BE/2.png?raw=true)


---

## Installation【安装】

### From CocoaPods【使用CocoaPods】

```ruby
pod  “JQSafeKit”
```

### Manually【手动导入】
- Drag all source files under floder `JQSafeKit` to your project.【将`JQSafeKit`文件夹中的所有源代码拽入项目中】


---
##使用方法

- 在AppDelegate的didFinishLaunchingWithOptions方法中添加如下代码，让JQSafeKit生效

```
//这句代码会让JQSafeKit生效，若没有如下代码，则JQSafeKit就不起作用
[JQSafeKit becomeEffective];
```

- 若你想要获取崩溃日志的所有详细信息，只需添加通知的监听，监听的通知名为:JQSafeKitNotification

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [JQSafeKit becomeEffective];
    
    //监听通知:JQSafeKitNotification, 获取JQSafeKit捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:JQSafeKitNotification object:nil];
    return YES;
}

- (void)dealwithCrashMessage:(NSNotification *)note {
//注意:所有的信息都在userInfo中
//你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"%@",note.userInfo);
}
```

- 下面通过打断点的形式来看下userInfo中的信息结构，看下包含了哪些信息

![userInfo信息结构.png](https://github.com/XiaoHanGe/JQSafeKit/blob/master/JQSafeKitDemo/%E6%88%AA%E5%9B%BE/3.png?raw=true)

- 再看下控制台输出日志来看下userInfo中的包含了哪些信息

![userInfo详细信息](https://github.com/XiaoHanGe/JQSafeKit/blob/master/JQSafeKitDemo/%E6%88%AA%E5%9B%BE/4.png?raw=true)



---

目前可以防止崩溃的方法有
===
---
- NSArray
-  `1. NSArray的快速创建方式 NSArray *array = @[@"HaRi", @"JQSafeKit"];  //这种创建方式其实调用的是2中的方法`
-  `2. +(instancetype)arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt`

- `3. - (id)objectAtIndex:(NSUInteger)index`

---

- NSMutableArray 
- `1. - (id)objectAtIndex:(NSUInteger)index`
- `2. - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx`
- `3. - (void)removeObjectAtIndex:(NSUInteger)index`
- `4. - (void)insertObject:(id)anObject atIndex:(NSUInteger)index`

---

- NSDictionary
- `1. NSDictionary的快速创建方式 NSDictionary *dict = @{@"frameWork" : @"JQSafeKit"}; //这种创建方式其实调用的是2中的方法`
- `2. +(instancetype)dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt`

---
- NSMutableDictionary
- `1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey`
- `2. - (void)removeObjectForKey:(id)aKey`



---
- NSString
- `1. - (unichar)characterAtIndex:(NSUInteger)index`
- `2. - (NSString *)substringFromIndex:(NSUInteger)from`
- `3. - (NSString *)substringToIndex:(NSUInteger)to {`
- `4. - (NSString *)substringWithRange:(NSRange)range {`
- `5. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement`
- `6. - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange`
- `7. - (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement`

---

- NSMutableString
- `1. 由于NSMutableString是继承于NSString,所以这里和NSString有些同样的方法就不重复写了`
- `2. - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString`
- `3. - (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc`
- `4. - (void)deleteCharactersInRange:(NSRange)range`



---


##[About me -- CSDN](http://blog.csdn.net/qq_31810357)
##iOS开发者交流群：446310206




