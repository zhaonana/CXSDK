//
//  Common.m
//  BXGameSDK
//
//  Created by JZY on 14-2-17.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import "Common.h"

static UserModel *_user;
static BOOL      _isBindPhone;

@implementation Common

+ (UserModel *)getUser
{
    if (!_user) {
        _user = [[UserModel alloc] init];
    }
    return _user;
}

+ (void)setUser:(UserModel *)mUser
{
    _user = mUser;
}

+ (void)setBindPhone:(BOOL)bindPhone
{
    _isBindPhone = bindPhone;
}

+ (BOOL)isBindPhone
{
    return _isBindPhone;
}

@end
