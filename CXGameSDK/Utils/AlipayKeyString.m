//
//  AlipayKeyString.m
//  CXGameSDK
//
//  Created by NaNa on 15/1/10.
//  Copyright (c) 2015年 nn. All rights reserved.
//

#import "AlipayKeyString.h"
#import "base64.h"

@implementation AlipayKeyString

+ (NSString *)getAlipayParam:(NSString *)param
{
    NSData *data = [Base64 decodeString:param];
    NSString *decodeParam = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *key = @"abcdefghijklmnABCDEFGHIJKLMNOPQRST123456!@#$%^&*()POIKJMNB";
    NSMutableString *revKey = [NSMutableString string];
    NSMutableString *appKey = [NSMutableString string];
    NSMutableString *resKey = [NSMutableString string];
    int length = 0;

    for (int i = key.length; i >0; i--) {
        [revKey appendString:[key substringWithRange:NSMakeRange(i - 1, 1)]];
    }
    
    if (decodeParam.length > key.length) {
        length = decodeParam.length;
    } else {
        length = key.length;
    }
    
    for (int i = 0; i < 30; i++) {
        [appKey appendString:key];
        [appKey appendString:revKey];
        [appKey appendString:[NSString stringWithFormat:@"%d",i]];
    }
    
    for (int i = 0; i < length; i++) {
        int charAtKey, charAtStr;
        if (i >= appKey.length) {
            charAtKey = 0;
        } else {
            charAtKey = (int)[appKey characterAtIndex:i];
        }
        if (i >= decodeParam.length) {
            continue;
        } else {
            charAtStr = (int)[decodeParam characterAtIndex:i];
        }
        char at = (char)(charAtKey ^ charAtStr);
        NSString *atStr = [NSString stringWithFormat:@"%c",at];
        [resKey appendString:atStr];
    }
    return resKey;
}

@end
