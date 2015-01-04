//
//  DeviceInfo.h
//  CXGameSDK
//
//  Created by NaNa on 14-10-24.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject

/**
 *  获得设备型号
 *
 *  @return 设备型号
 */
+ (NSString*)getDeviceVersion;

/**
 *  获得IDFA-identifierForIdentifie
 *
 *  @return IDFA-identifierForIdentifie
 */
+ (NSString *)getIDFA;

@end
