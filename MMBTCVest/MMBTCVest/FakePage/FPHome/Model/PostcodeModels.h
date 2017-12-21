//
//  PostcodeModels.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/11.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostcodeModel;
@interface PostcodeModels : NSObject

// 消息体的JSON封装，所有应用级的返回参数将嵌入此对象 。
@property (nonatomic, strong) PostcodeModel *showapi_res_body;
// 错误信息的展示
@property (nonatomic, copy) NSString *showapi_res_error;
// 易源返回标志,0为成功，其他为失败。0成功
@property (nonatomic, assign) CGFloat showapi_res_code;


@end



@class PostcodeContentModel;
@interface PostcodeModel : NSObject

// 错误码
@property (nonatomic, strong) NSArray *content;
// 错误码
@property (nonatomic, copy) NSString *error_code;
// 查询成功	错误描述
@property (nonatomic, copy) NSString *error_description;
// 当前页码
@property (nonatomic, copy) NSString *page;
// 页码总数
@property (nonatomic, copy) NSString *page_max;
// 记录数
@property (nonatomic, copy) NSString *count;



@end


