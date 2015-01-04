//
//  StringUtil.m
//  BXGameSDK
//
//  Created by JZY on 14-1-24.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

+ (BOOL)isEmpty:(NSString *) str
{
    if (str && [str length] > 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)isNotEmpty:(NSString *) str
{
    return ![StringUtil isEmpty:str];
}

@end
