//
//  URLChangeTool.h
//  MInfoQuery
//
//  Created by dodreamteam on 2017/7/13.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLChangeTool : NSObject

//单例创建
+ (instancetype)shareInstance;

//将加密接口解析成API
- (NSString *)changeUiWithUrlTarget:(NSString *)target Pass:(NSString *)pass;

@end
