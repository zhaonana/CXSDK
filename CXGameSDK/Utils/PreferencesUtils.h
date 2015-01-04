//
//  PreferencesUtils.h
//  BXGameSDK
//
//  Created by JZY on 14-1-23.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHostServer @""
#define kHostPath @"//"

@interface PreferencesUtils : NSObject

//通过字符串转换为URL
+ (NSURL *)makeURLForPath:(NSString *)path;

//通过URL转换为字符串
+ (NSString *)makeURLStrForPath:(NSString *)path;

//配置文件添加参数
+ (void)putString:(NSString *)key value:(NSString *)value;

//配置文件获取参数
+ (NSString *)getStringForKey:(NSString *) key;

//清空配置文件
+ (void)clearConfig;

//检验Email格式
+ (BOOL)isValidateEmail:(NSString *)Email;

//检验phone格式
+ (BOOL)isValidateMobile:(NSString *)mobile;

//弹出框
+ (void)showAlert:(NSString *)msg;

//弹出成功框
+ (void)showSucessAlert:(NSString *)msg;

//通过File获取Json字典
+ (NSDictionary *)getJsonFromFile:(NSString *)filePath;

@end
