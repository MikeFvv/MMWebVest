//
//  ResultPhoneModels.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/11.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultPhoneModel.h"

@interface ResultPhoneModels : NSObject

// 消息体的JSON封装，所有应用级的返回参数将嵌入此对象 。
@property (nonatomic, strong) ResultPhoneModel *showapi_res_body;
// 错误信息的展示
@property (nonatomic, copy) NSString *showapi_res_error;
// 易源返回标志,0为成功，其他为失败。0成功
@property (nonatomic, assign) CGFloat showapi_res_code;



@end
