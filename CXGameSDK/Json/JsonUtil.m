//
//  JsonUtil.m
//  BXGameSDK
//
//  Created by JZY on 14-2-17.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import "JsonUtil.h"

@implementation JsonUtil

+ (UserModel*)parseUserModel:(NSDictionary *)dic
{
    UserModel *user = [[UserModel alloc] init];
    if(dic){
        user.username = [dic objectForKey:@"username"];
        user.password = [dic objectForKey:@"password"];
        user.user_id = [dic objectForKey:@"user_id"];
        user.adult = [dic objectForKey:@"adult"];
        user.ticket = [dic objectForKey:@"ticket"];
        user.nick_name = [dic objectForKey:@"nick_name"];
        user.origin = [dic objectForKey:@"origin"];
    }
    
    return user;
}

+ (NSMutableArray*)parseUserModelArray:(NSArray *)array
{
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in array) {
        if(dic){
            UserModel *user = [[UserModel alloc] init];
            user.user_id = [dic objectForKey:@"user_id"];
            user.username = [dic objectForKey:@"username"];
            user.password = [dic objectForKey:@"password"];
            user.adult = [dic objectForKey:@"adult"];
            user.ticket = [dic objectForKey:@"ticket"];
            user.nick_name = [dic objectForKey:@"nick_name"];
            user.origin = [dic objectForKey:@"origin"];
            [userArray addObject:user];
        }
    }
    
    return userArray;
}

+ (NSMutableArray*)parseUserModelArrayStr:(NSArray *)array
{
    NSMutableArray *userArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in array) {
        if(dic){
            UserModel *user = [[UserModel alloc] init];
            user.user_id = [dic objectForKey:@"user_id"];
            user.username = [dic objectForKey:@"username"];
            user.password = [dic objectForKey:@"password"];
            user.adult = [dic objectForKey:@"adult"];
            user.ticket = [dic objectForKey:@"ticket"];
            user.nick_name = [dic objectForKey:@"nick_name"];
            user.origin = [dic objectForKey:@"origin"];
            [userArray addObject:user];
        }
    }
    
    return userArray;
}

+ (NSString *)toJson:(id)data
{
    NSString *json;
    if ([NSJSONSerialization isValidJSONObject:data])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return json;
}

+ (NSString *)toUserArrayJson:(NSArray*) array
{
    NSMutableArray *jsonArray = [[NSMutableArray alloc] init];
    for (UserModel *user in array) {
        [jsonArray addObject:[user getDic]];
    }
    
    NSString *json;
    if ([NSJSONSerialization isValidJSONObject:jsonArray])
    {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:&error];
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return json;
}

+ (id)toArrayOrNSDictionary:(NSData *)jsonData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil) {
        return jsonObject;
    } else {
        // 解析错误
        return nil;
    }
    
}

@end
