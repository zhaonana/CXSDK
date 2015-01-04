//
//  CXComPlatformBase.m
//  CXGameSDK
//
//  Created by NaNa on 14-11-14.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "CXComPlatformBase.h"
#import "CXSDKViewController.h"

static CXComPlatformBase *sharedSingleton = nil;
@implementation CXComPlatformBase

+ (CXComPlatformBase *)defaultPlatform
{
    if (sharedSingleton == nil) {
        sharedSingleton = [[CXComPlatformBase alloc] init];
    }
    return sharedSingleton;
}

- (void)CXInit:(CXInitConfigure *)configure
{
    CXSDKViewController *cxVC = [[CXSDKViewController alloc] init];
    [cxVC setAppID:configure.appId];
    [cxVC setCpKey:configure.cpKey];
    [cxVC setServerID:configure.serverId];
    [cxVC initSDK:configure.controller];
}

@end
