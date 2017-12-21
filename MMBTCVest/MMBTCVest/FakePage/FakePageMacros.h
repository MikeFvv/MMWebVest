//
//  FakePageMacros.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/3.
//  Copyright © 2017年 dodremteam. All rights reserved.
//


// 甲页面  宏 定义
#ifndef FakePageMacros_h
#define FakePageMacros_h


#import "UIViewController+HUD.h"
#import "NSString+RegexCategory.h"

#import "BANetManager.h"
#import "UIImage+compressIMG.h"
#import "NSString+Directory.h"

#import "Masonry.h"
#import "CommonMacros.h"
#import "MJRefresh.h"


#import "MJExtension.h"
#import "UIResponder+GXRouter.h"
#import "SDWebImageManager.h"
#import "UserDefaultsTools.h"
#import "BANetManager_OC.h"





// 甲页面判断存储 key
#define CD_JugdeIsOnLine @"device"

#define SN_Userdefaults [NSUserDefaults standardUserDefaults] //

// 用户登录基本信息Key
#define CD_APPURL @"APPURL"                //AppUrl地址，每套App API不同

#define CD_RequestUrl @"RequestUrl"        //解析出来的





#define kHomeViewSpacing kUIScreenWidth_Scale_iPhone6(18)
// 灰白色
#define kFakePageMainColor [UIColor colorWithRed: 0.937 green: 0.937 blue: 0.957 alpha: 1]
// 粉红色  导航栏字体颜色
#define kColorPink [UIColor colorWithRed: 1 green: 0.949 blue: 0.953 alpha: 1]

/** 手机归属地查询 秘钥 －－－－－apikey*/
#define apikey  @"2b8b3da87db542f4900e4102f93dba6a"


// 导航栏颜色
#define APPCOLOR [UIColor colorWithRed: 1 green: 0.2 blue: 0.2 alpha: 1]





#define kFontTitle 14
#define kFontText 12
#define kFontSpacingkWidth 2
#define kViewTextHeight 13
#define kFontSize 12
#define kViewMargin 12
#define kTextMargin 10


#endif /* FakePageMacros_h */
