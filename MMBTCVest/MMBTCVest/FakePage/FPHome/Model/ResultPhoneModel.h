//
//  ResultModel.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/11.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultPhoneModel : NSObject

// 城市区号，座机号码前几位
@property (nonatomic, copy) NSString *areaCode;
// 城市编码编码，本城市身份证的前几位编码。
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *postCode;
// 市
@property (nonatomic, copy) NSString *city;
// 省
@property (nonatomic, copy) NSString *prov;
@property (nonatomic, copy) NSString *num;
// 1为移动 2为电信 3为联通
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) CGFloat ret_code;
// 运营商
@property (nonatomic, copy) NSString *name;
// 省份编码
@property (nonatomic, copy) NSString *provCode;


@end




