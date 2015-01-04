//
//  UserModel.m
//  BXGameSDK
//
//  Created by JZY on 14-2-17.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSDictionary*)getDic
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         self.user_id, @"user_id",
                         self.username, @"username",
                         self.password, @"password",
                         self.adult, @"adult",
                         self.ticket, @"ticket",
                         self.nick_name, @"nick_name",
                         self.origin, @"origin",
                         nil];
    return dic;
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.user_id = [decoder decodeObjectForKey:@"user_id"];
    self.username = [decoder decodeObjectForKey:@"username"];
    self.password = [decoder decodeObjectForKey:@"password"];
    self.adult = [decoder decodeObjectForKey:@"adult"];
    self.ticket = [decoder decodeObjectForKey:@"ticket"];
    self.nick_name = [decoder decodeObjectForKey:@"nick_name"];
    self.origin = [decoder decodeObjectForKey:@"origin"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.user_id forKey:@"user_id"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.adult forKey:@"adult"];
    [encoder encodeObject:self.ticket forKey:@"ticket"];
    [encoder encodeObject:self.nick_name forKey:@"nick_name"];
    [encoder encodeObject:self.origin forKey:@"origin"];

}

@end
