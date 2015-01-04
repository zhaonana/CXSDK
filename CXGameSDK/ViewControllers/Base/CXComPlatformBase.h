//
//  CXComPlatformBase.h
//  CXGameSDK
//
//  Created by NaNa on 14-11-14.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXInitConfigure.h"

//登录成功通知
#define LOGIN_SUCCESSED_NOTIFICATION @"loginSuccessedNotification"
//登录失败通知
#define LOGIN_FAILED_NOTIFICATION @"loginFailedNotification"

@interface CXComPlatformBase : NSObject

/**
 *  获取CXComPlatformBase的实例对象
 *
 *  @return CXComPlatformBase
 */
+ (CXComPlatformBase *)defaultPlatform;

/**
 *  应用初始化
 *
 *  @param configure 初始化配置类
 */
- (void)CXInit:(CXInitConfigure *)configure;

@end
