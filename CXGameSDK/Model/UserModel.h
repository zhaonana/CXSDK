//
//  UserModel.h
//  BXGameSDK
//
//  Created by JZY on 14-2-17.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *user_id;    //畅想游戏 账号 用户唯一编号
@property (nonatomic, strong) NSString *username;   //用户名
@property (nonatomic, strong) NSString *password;   //密码
@property (nonatomic, strong) NSString *adult;      //用户成年标识 1=成年 0=未成年
@property (nonatomic, strong) NSString *ticket;     //用户登录成功的票据 用于服务器端验证用户合法性
@property (nonatomic, strong) NSString *nick_name;  //用户昵称
@property (nonatomic, strong) NSString *origin;     //0 畅想用户 1 QQ 2 sina

- (NSDictionary*)getDic;

@end
