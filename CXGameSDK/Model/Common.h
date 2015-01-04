//
//  Common.h
//  BXGameSDK
//
//  Created by JZY on 14-2-17.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "CXSDKViewController.h"

@interface Common : NSObject

+ (UserModel *)getUser;
+ (void)setUser:(UserModel *)mUser;
+ (void)setBindPhone:(BOOL)bindPhone;
+ (BOOL)isBindPhone;

@end
