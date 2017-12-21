//
//  ExpressQueryModel.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/14.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressQueryModel : NSObject

// 快递公司名称
@property (nonatomic, copy) NSString *expTextName;
// 公司英文
@property (nonatomic, copy) NSString *expSpellName;
// 快递单号
@property (nonatomic, copy) NSString *mailNo;
// 更新时间
@property (nonatomic, copy) NSString *update;
// 联系电话
@property (nonatomic, copy) NSString *tel;
// 快递配送信息
@property (nonatomic, copy) NSString *data;

// -1 待查询
//0 查询异常
//1 暂无记录
//2 在途中
//3 派送中
//4 已签收
//5 用户拒签
//6 疑难件
//7 无效单
//8 超时单
//9 签收失败
//10 退回
@property (nonatomic, copy) NSString *status;

// 接口调用是否成功,0表示成功,其他为失败
@property (nonatomic, copy) NSString *ret_code;
// 在auto的情况下,返回可能的快递列表simpleName快递简称、expName快递公司名
@property (nonatomic, copy) NSString *possibleExpList;
// 快递公司的简称
@property (nonatomic, copy) NSString *simpleName;
// 顺丰-	快递名
@property (nonatomic, copy) NSString *expName;


@end


