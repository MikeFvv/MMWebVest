//
//  UIResponder+GXRouter.m
//  MInfoQuery
//
//  Created by dodreamteam on 2017/4/25.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import "UIResponder+GXRouter.h"

@implementation UIResponder (GXRouter)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}
@end
