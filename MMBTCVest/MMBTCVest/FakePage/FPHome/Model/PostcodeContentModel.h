//
//  PostcodeContentModel.h
//  MInfoQuery
//
//  Created by Mike on 2017/8/12.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostcodeContentModel : NSObject


@property (nonatomic, copy  ) NSString *Id;
// 地址
@property (nonatomic, copy) NSString *addr;
// 邮政编码
@property (nonatomic, copy) NSString *zip;

@end
