//
//  PreferencesUtils.m
//  BXGameSDK
//
//  Created by JZY on 14-1-23.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import "PreferencesUtils.h"
#import "SVProgressHUD.h"

#define kConfigFile @"USER_CONFIG_FILE"

@implementation PreferencesUtils


+ (NSURL *)makeURLForPath:(NSString *)path
{
    NSString *urlEncodingPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString;
    
    urlString = [kHostServer stringByAppendingString:urlEncodingPath];
    
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

+ (NSString *)makeURLStrForPath:(NSString *)path
{
    NSString *urlEncodingPath = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString;
    
    urlString = [kHostServer stringByAppendingString:urlEncodingPath];
    
    return urlString;
}

+ (void)putString:(NSString *)key value:(NSString *)value
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:value forKey:key];
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kConfigFile];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getStringForKey:(NSString *)key
{
    NSMutableDictionary *dic = [PreferencesUtils getUserAccountInfo];
    return [dic objectForKey:key];
}

+ (NSMutableDictionary *)getUserAccountInfo
{
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigFile];
    if (!dic) {
        dic = [[NSMutableDictionary alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:kConfigFile];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return dic;
}

+ (void)clearConfig
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kConfigFile];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)isValidateEmail:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    return isMatch;
}

#pragma mark -
#pragma mark - UI

+ (void)showAlert:(NSString *)msg
{
    [SVProgressHUD showErrorWithStatus:msg];
}

+ (void)showSucessAlert:(NSString *)msg
{
    [SVProgressHUD showSuccessWithStatus:msg];
}
#pragma mark -
#pragma mark - UI

+ (NSDictionary *)getJsonFromFile:(NSString *)filePath
{
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *JSON =
    [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: NULL];
    return JSON;
}

@end
