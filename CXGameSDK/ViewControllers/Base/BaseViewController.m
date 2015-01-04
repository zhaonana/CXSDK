//
//  BaseViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "PreferencesUtils.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveUsers:(UserModel*)user
{
    //还原UserModel数组
    NSString *json = [PreferencesUtils getStringForKey:kUserNames];
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *userArray = [JsonUtil parseUserModelArrayStr:[self parseJsonData:data]];
    if (!userArray) {
        userArray = [[NSMutableArray alloc] init];
    }
    
    //判断是否已经存储
    if(userArray && [userArray count] > 0){
        for (UserModel *mUser in userArray) {
            if([mUser.nick_name isEqualToString:user.nick_name]){
                [userArray removeObject:mUser];
                break;
            }
        }
    }
    
    //存储用户信息
    [userArray addObject:user];
    NSString *usersJson = [JsonUtil toUserArrayJson:userArray];
    [PreferencesUtils putString:kUserNames value:usersJson];
}

- (NSMutableArray*)parseJsonData:(NSData *)data
{
    if (data == nil) {
        return [[NSMutableArray alloc] init];
    }
    NSError *error;
    NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (jsonArray == nil) {
        return [[NSMutableArray alloc] init];
    }
    return jsonArray;
}

- (void)showToast:(NSInteger)code
{
    NSString *msg;
    switch (code) {
		case SYSTEM_ERROR:
			msg = @"系统错误";
			break;
		case USER_NOT_EXIST:
			msg = @"用户不存在";
			break;
		case LOGIN_ERROR:
			msg = @"登录时密码错误";
			break;
		case USER_EXIST:
			msg = @"用户已经存在";
			break;
        case NEWPWD_AND_OLDPWD_MATE:
            msg = @"新密码与原始密码相同";
            break;
        case PHONE_AUTH_CODE_PAST_DUE:
            msg = @"验证码过期";
            break;
        case PHONE_AUTH_CODE_ERROR:
            msg = @"验证码不正确";
            break;
        case PHONE_HAS_BIND:
            msg = @"手机号已经被使用";
            break;
		case BIND_HAS:
			msg = @"已经绑定手机号";
			break;
        case UNBIND_MOBILE:
            msg = @"没有绑定手机号";
            break;
        case PARAM_ERROR:
			msg = @"参数格式不正确";
			break;
		case NOW_PHONE_OR_BAND_PHONE_ERROR:
			msg = @"输入的手机号与绑定的手机号不一致";
			break;
		case USERNAME_INVALID:
			msg = @"用户名不合法";
			break;
		case PWSSWORD_UNDER_SIX:
			msg = @"密码必须为6-20个英文字母或数字";
			break;
		case ORDER_NUMBER_INVALID:
			msg = @"订单号少于24个字符";
			break;
		case SHOP_NOT_EXIST:
			msg = @"商品不存在";
			break;
        case SHOP_NOT_USE:
            msg = @"商品不可用";
            break;
        case CREATE_ORDER_ERROR:
            msg = @"生成订单失败";
            break;
        case APP_STORY_PRODUCT_ERROR:
            msg = @"票据正确，但商品不存在";
            break;
        case APP_STORY_PAY_ERROR:
            msg = @"支付错误";
            break;
		default:
			msg = @"错误码1001";
    }
    [SVProgressHUD showErrorWithStatus:msg];
}

- (void)resetView
{
    
}

//点击return时触发的事件
- (void)textFiledReturnEditing:(id)sender
{
    [sender resignFirstResponder];
}

#pragma mark textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
