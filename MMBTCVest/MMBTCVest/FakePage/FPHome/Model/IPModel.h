//
//  IPModel.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/12.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPModel : NSObject

// "0"时表示业务成功
@property (nonatomic, copy) NSString *ret_code;
// 请填写参数描述
@property (nonatomic, copy) NSString *region;


@end
