//
//  DeviceInfo.m
//  CXGameSDK
//
//  Created by NaNa on 14-10-24.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "DeviceInfo.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <AdSupport/AdSupport.h>

@implementation DeviceInfo

+ (NSString *)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)getIDFA
{
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return adId;
}

@end
