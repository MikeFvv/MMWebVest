//
//  URLChangeTool.m
//  MInfoQuery
//
//  Created by dodreamteam on 2017/7/13.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

//请求---------http://uploads.bxvip588.com/bxvip/list.php
//得到的是------7682827E483D3D8585853C708684777E4346463C717D7B3D777C7273863C7E767E3D5E767D7C734F7E773D80737F83738182
//解密后结果是---http://www.bxvip588.com/index.php/PhoneApi/request

#import "URLChangeTool.h"

@implementation URLChangeTool

static URLChangeTool* _instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

- (NSString *)changeUiWithUrlTarget:(NSString *)target Pass:(NSString *)pass
{
//    NSString *target1 = @"7682827E483D3D8585853C708684777E4346463C717D7B3D777C7273863C7E767E3D5E767D7C734F7E773D80737F83738182";
//    NSString *pass1 = @"bxvip588";

    NSString *result = @"";
    NSMutableArray *codes =[[NSMutableArray alloc] init];

    //获取密码的ascii码
    for(int i=0; i<[pass length]; i++)
    {
        NSString *temp = [pass substringWithRange:NSMakeRange(i,1)];
        NSString *objStr = [NSString stringWithFormat:@"%d",[temp characterAtIndex:0]];
        [codes addObject:objStr];
    }

    for (int i=0; i<[target length]; i+=2)
    {
        int ascii = [[self numberHexString:[target substringWithRange:NSMakeRange(i, 2)]] intValue];
        for (int j = (int)[codes count]; j>0; j--)
        {
            int val = ascii - [(codes[j-1]) intValue]*j;
            if (val < 0)
            {
                ascii = 256 - (abs(val)%256);
            }
            else
            {
                ascii = val%256;
            }
        }
        result = [result stringByAppendingString:[NSString stringWithFormat:@"%c", ascii]];

    }

    return result;
}

//16进制转10进制
- (NSNumber *)numberHexString:(NSString *)aHexString
{
    //为空,直接返回.
    if (nil == aHexString)
    {
        return nil;
    }
    
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    
    //将整数转换为NSNumber,存储到数组中,并返回.
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    
    return hexNumber;
}


@end
