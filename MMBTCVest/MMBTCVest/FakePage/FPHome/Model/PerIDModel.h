//
//  PerIDModel.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/11.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PerIDRetDataModel.h"

@interface PerIDModel : NSObject

// 错误码
@property (nonatomic, copy) NSString *errNum;
// 身份证数据结构
@property (nonatomic, strong) PerIDRetDataModel *retData;
// 消息提示
@property (nonatomic, copy) NSString *retMsg;
// 
@property (nonatomic, copy) NSString *ret_code;






@end
