//
//  AppDelegate.h
//  MMBTCVest
//
//  Created by Mike on 2017/12/21.
//  Copyright © 2017年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSDictionary *launchOptions;
@property (nonatomic, strong) UIViewController *nativeRootController;
@property (nonatomic, strong) UIViewController *reactNativeRootController;
@property (nonatomic, strong) UIViewController *webRootController;

@property (nonatomic, copy) NSString *is_jump;
@property (nonatomic, copy) NSString *pushKey;
@property (nonatomic, assign) NSString *mmUrl;
@property (nonatomic, assign) NSInteger mmStatus;
@property (nonatomic, assign) BOOL isRoute;


@end

