//
//  PerIDRetDataModel.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/12.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerIDRetDataModel : NSObject

// 籍贯
@property (nonatomic, copy) NSString *address;
// 生日
@property (nonatomic, copy) NSString *birthday;
// F	性别，M为男性，F为女性
@property (nonatomic, copy) NSString *sex;

@end
