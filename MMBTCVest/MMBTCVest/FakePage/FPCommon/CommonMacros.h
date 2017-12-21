//
//  CommonMacros.h
//  YhoLinkCar
//
//  Created by Mike on 16/8/9.
//  Copyright © 2016年 Mike. All rights reserved.
//


/// 每个项目都需使用的公共配置宏

#ifndef CommonMacros_h
#define CommonMacros_h






/*********** 数字 宽高 ***********/

#pragma mark - 获取屏幕宽度与高度
// 获取屏幕宽度与高度
#define kUIScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight      [UIScreen mainScreen].bounds.size.height


// 导航栏44+状态栏20 （象素高）
#define kUINavHeight 64
// 选项卡  工具栏
#define kUITabBarHeight 49
// 导航栏44
#define kUIPopViewHeight 44

// iPhone6 高度
#define kIPHONE6Height 667

// 适配屏幕比例 iPhone6
#define kUIScreenWidth_Scale_iPhone6(_X_) (_X_ * (kUIScreenWidth/375))
// 适配屏幕比例 iPhone6
#define kUIScreenHeight_Scale_iPhone6(_X_) (_X_ * (kUIScreenHeight/667))

/************  系统版本  ************/

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 获取系统版本号
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
// 判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

/************ iPhone的型号 ************/
#define IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)  // 宽 320
#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)  // 宽 320
#define IS_IPHONE6 ([[UIScreen mainScreen] bounds].size.height == 667)  // 宽 375
#define IS_IPHONE6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736)  // 宽 414


// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f




#pragma mark - 颜色

// 设置随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

// 设置RGB颜色/设置RGBA颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]


//  (0xFFFFFF)
#define HEX_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HEX_RGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]






// *************************** 提示信息 ****************************
#pragma mark - 设置加载提示框（第三方框架：Toast）
// 设置加载提示框（第三方框架：Toast）

// 此宏定义非常好用，但是小伙伴需要CocoaPods导入第三方框架：Toast
// 使用方法如下：
// LRToast(@"网络加载失败");
#define Toast(str)              CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[kWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
kWindow.userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
kWindow.userInteractionEnabled = YES;\
});\


// 系统提示信息
/// 弹框(传入内容)   确定框  点击确定消失
#define CDAlert(text) UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message: text delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil]; [alert show]

// 原生弹出信息
#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show]




#pragma mark - 判断是否空对象 空数组
// 是否为空对象
#define kObjectIsNil(__object)     ((nil == __object) || [__object isKindOfClass:[NSNull class]])
// 数组为空
#define kArrayIsEmpty(__array) ((__array==nil) || ([__array isKindOfClass:[NSNull class]]) || (array.count==0))


#pragma mark - GCD

//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);



#pragma mark - 获取当前语言
// 获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])



#pragma mark - Log


//  *********  原先的  现在用下面的*********
// 日记输出宏
#ifdef DEBUG // 调试状态, 打开LOG功能

#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define CDLog(...) printf("[文件名:%s] [函数名:%s] [行号:%d]: %s\n\n",[[NSString lr_stringDate] UTF8String], [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
//#define YHLog(...) NSLog(__VA_ARGS__)
#else  // 发布状态, 关闭LOG功能
#define CDLog(...)
#endif


//真机调试不显示打印
#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...)
#endif

#ifdef __OPTIMIZE__
#define NSLog(...)
#endif


#ifdef DEBUG
# define CLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define CLog(...);
#endif




#pragma mark - 真机 / 模拟器判断

/*** 判断设备室真机还是模拟器 ***/
#if TARGET_OS_IPHONE  //真机
// iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR  //模拟器
// iPhone Simulator
#endif




#pragma mark - 使用 ARC 和 MRC

// 使用 ARC 和 MRC
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif



#endif /* CommonMacros_h */





