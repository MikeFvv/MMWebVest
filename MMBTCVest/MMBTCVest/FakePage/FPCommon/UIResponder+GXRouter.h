//
//  UIResponder+GXRouter.h
//  MInfoQuery
//
//  Created by dodreamteam on 2017/4/25.
//  Copyright © 2017年 dodremteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (GXRouter)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end
