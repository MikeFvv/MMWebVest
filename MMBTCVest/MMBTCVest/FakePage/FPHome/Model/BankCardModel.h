//
//  BankCardModel.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/12.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

// 0为成功，其他失败
@property (nonatomic, copy) NSString *ret_code;
// 地区
@property (nonatomic, copy) NSString *area;
// 银行客服
@property (nonatomic, copy) NSString *tel;
// 银行卡产品名称
@property (nonatomic, copy) NSString *brand;
// 银行名称
@property (nonatomic, copy) NSString *bankName;
// 银行卡种
@property (nonatomic, copy) NSString *cardType;
// 银行官网
@property (nonatomic, copy) NSString *url;
// 卡号
@property (nonatomic, copy) NSString *cardNum;


@end
