//
//  BaseViewController.h
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXSDKViewController.h"
#import "UserModel.h"
#import "StringUtil.h"
#import "SVProgressHUD.h"
#import "GGNetWork.h"
#import "JsonUtil.h"
#import "Common.h"

#define kUserNames @"user_names"
#define kSaveUser @"save_user"

// 操作成功
#define SUCCESS 1
// 系统错误
#define SYSTEM_ERROR 10000
// 用户不存在
#define USER_NOT_EXIST 10001
// 登录时密码错误
#define LOGIN_ERROR 10002
// 用户已经存在
#define USER_EXIST 10003
// 新密码与原始密码相同
#define NEWPWD_AND_OLDPWD_MATE 10004
// 验证码过期
#define PHONE_AUTH_CODE_PAST_DUE 10005
// 验证码不正确
#define PHONE_AUTH_CODE_ERROR 10006
// 手机已经被使用
#define PHONE_HAS_BIND 10007
// 已经绑定手机号
#define BIND_HAS 10008
// 没有绑定手机号
#define UNBIND_MOBILE 10009
// 参数格式不正确
#define PARAM_ERROR 10010
// 输入的手机号与绑定的手机号不一致
#define NOW_PHONE_OR_BAND_PHONE_ERROR 10011
// 用户名不合法
#define USERNAME_INVALID 10012
// 密码必须为6-20个英文字母或数字
#define PWSSWORD_UNDER_SIX 10013
// 订单号少于24个字符
#define ORDER_NUMBER_INVALID 10018
// 商品不存在
#define SHOP_NOT_EXIST 20000
// 商品不可用
#define SHOP_NOT_USE 20001
// 生成订单失败
#define CREATE_ORDER_ERROR 20003
// 票据正确，但商品不存在
#define APP_STORY_PRODUCT_ERROR 20006
// 苹果支付错误
#define APP_STORY_PAY_ERROR 20007

@interface BaseViewController : UIViewController <UITextFieldDelegate> {
    UIView *_paddingView;
}

@property (nonatomic, strong) CXSDKViewController *rootView;

- (void)showToast:(NSInteger)code;

- (void)saveUsers:(UserModel *)user;

- (void)resetView;

- (void)textFiledReturnEditing:(id)sender;

- (NSMutableArray *)parseJsonData:(NSData *)data;

@end
