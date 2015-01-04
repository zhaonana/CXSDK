//
//  RegistViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "RegistViewController.h"
#import "TalkingDataAppCpa.h"

@interface RegistViewController () {
    UITextField *_accountField;
    UITextField *_passWordField;
    UITextField *_surePassWordField;
}

@end

@implementation RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self setUpSubViews];
    } else {
        [self setUpPadSubViews];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(26, 88, 177, 27)];
    [accountView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:accountView];
    
    //set accountBackgroundView
    UIImageView *accountBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [accountBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [accountView addSubview:accountBackView];
    
    //set accountImgView
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [accountImgView setImage:[UIImage imageNamed:@"CXzhanghao"]];
    [accountView addSubview:accountImgView];
    
    //set accountTextField
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 130, 14)];
    [_accountField setPlaceholder:@"请输入用户名"];
    [_accountField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setFont:[UIFont systemFontOfSize:13.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set passWordView
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(26, 122, 177, 27)];
    [passWordView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:passWordView];
    
    //set passWordBackgroundView
    UIImageView *passWordBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [passWordBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [passWordView addSubview:passWordBackView];
    
    //set passWordImgView
    UIImageView *passWordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [passWordImgView setImage:[UIImage imageNamed:@"CXmima"]];
    [passWordView addSubview:passWordImgView];
    
    //set passWordTextField
    _passWordField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 130, 14)];
    [_passWordField setPlaceholder:@"请输入密码"];
    [_passWordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWordField setFont:[UIFont systemFontOfSize:13.0]];
    [_passWordField setTextColor:[UIColor whiteColor]];
    _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passWordField setReturnKeyType:UIReturnKeyDone];
    _passWordField.secureTextEntry = YES;
    _passWordField.delegate = self;
    [passWordView addSubview:_passWordField];
    
    //set surePassWordView
    UIView *surePassWordView = [[UIView alloc] initWithFrame:CGRectMake(26, 156, 177, 27)];
    [surePassWordView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:surePassWordView];
    
    //set surePassWordBackgroundView
    UIImageView *surePassWordBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [surePassWordBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [surePassWordView addSubview:surePassWordBackView];
    
    //set surePassWordImgView
    UIImageView *surePassWordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [surePassWordImgView setImage:[UIImage imageNamed:@"CXmima"]];
    [surePassWordView addSubview:surePassWordImgView];
    
    //set surePassWordTextField
    _surePassWordField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 130, 14)];
    [_surePassWordField setPlaceholder:@"请输入确认密码"];
    [_surePassWordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_surePassWordField setFont:[UIFont systemFontOfSize:13.0]];
    [_surePassWordField setTextColor:[UIColor whiteColor]];
    _surePassWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_surePassWordField setReturnKeyType:UIReturnKeyDone];
    _surePassWordField.secureTextEntry = YES;
    _surePassWordField.delegate = self;
    [surePassWordView addSubview:_surePassWordField];
    
    //set registBtn
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 193, 84, 27)];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitle:@"注册" forState:UIControlStateHighlighted];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    //set backBtn
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 193, 84, 27)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateHighlighted];
    [backBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)setUpPadSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(29, 105, 228, 35)];
    [accountView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:accountView];
    
    //set accountBackgroundView
    UIImageView *accountBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [accountBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [accountView addSubview:accountBackView];
    
    //set accountImgView
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [accountImgView setImage:[UIImage imageNamed:@"padZhanghao"]];
    [accountView addSubview:accountImgView];
    
    //set accountTextField
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 180, 15)];
    [_accountField setPlaceholder:@"请输入用户名"];
    [_accountField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setFont:[UIFont systemFontOfSize:15.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set passWordView
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(29, 149, 228, 35)];
    [passWordView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:passWordView];
    
    //set passWordBackgroundView
    UIImageView *passWordBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [passWordBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [passWordView addSubview:passWordBackView];
    
    //set passWordImgView
    UIImageView *passWordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [passWordImgView setImage:[UIImage imageNamed:@"padMima"]];
    [passWordView addSubview:passWordImgView];
    
    //set passWordTextField
    _passWordField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 180, 15)];
    [_passWordField setPlaceholder:@"请输入密码"];
    [_passWordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passWordField setFont:[UIFont systemFontOfSize:15.0]];
    [_passWordField setTextColor:[UIColor whiteColor]];
    _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passWordField setReturnKeyType:UIReturnKeyDone];
    _passWordField.secureTextEntry = YES;
    _passWordField.delegate = self;
    [passWordView addSubview:_passWordField];
    
    //set surePassWordView
    UIView *surePassWordView = [[UIView alloc] initWithFrame:CGRectMake(29, 193, 228, 35)];
    [surePassWordView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:surePassWordView];
    
    //set surePassWordBackgroundView
    UIImageView *surePassWordBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [surePassWordBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [surePassWordView addSubview:surePassWordBackView];
    
    //set surePassWordImgView
    UIImageView *surePassWordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [surePassWordImgView setImage:[UIImage imageNamed:@"padMima"]];
    [surePassWordView addSubview:surePassWordImgView];
    
    //set surePassWordTextField
    _surePassWordField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 180, 15)];
    [_surePassWordField setPlaceholder:@"请输入确认密码"];
    [_surePassWordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_surePassWordField setFont:[UIFont systemFontOfSize:15.0]];
    [_surePassWordField setTextColor:[UIColor whiteColor]];
    _surePassWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_surePassWordField setReturnKeyType:UIReturnKeyDone];
    _surePassWordField.secureTextEntry = YES;
    _surePassWordField.delegate = self;
    [surePassWordView addSubview:_surePassWordField];
    
    //set registBtn
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 237, 107, 35)];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitle:@"注册" forState:UIControlStateHighlighted];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    //set backBtn
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 237, 107, 35)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateHighlighted];
    [backBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [backBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

#pragma mark - UIButtonClick
/**
 *  注册
 */
- (void)registBtnClick
{
    [_accountField resignFirstResponder]; //关闭输入法键盘
    [_passWordField resignFirstResponder]; //关闭输入法键盘
    [_surePassWordField resignFirstResponder]; //关闭输入法键盘

    NSString *username = _accountField.text;
    NSString *password = _passWordField.text;
    NSString *surePassword = _surePassWordField.text;
    
    if ([StringUtil isEmpty:username]) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    
    if ([StringUtil isEmpty:password]) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    }
    
    if (![password isEqualToString:surePassword]){
        [SVProgressHUD showErrorWithStatus:@"确认密码不正确"];
        return;
    }
    
    if (username.length < 4 || username.length > 16) {
        [SVProgressHUD showErrorWithStatus:@"用户名必须为4-16位"];
        return;
    }
    if (password.length < 6 || password.length > 20) {
        [SVProgressHUD showErrorWithStatus:@"密码必须为6-20个英文字母或数字"];
        return;
    }
    
    NSDictionary *dic = @{@"username": username,
                          @"password": password,
                          @"isGuset": @"0"
                          };
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"user/register" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if(code == 1){
                //发送回调
                NSDictionary *dic = [responseObj objectForKey:@"data"];
                UserModel *user = [JsonUtil parseUserModel:dic];
                user.username = username;
                user.password = password;
                
                //保存账户密码
                [self saveUsers:user];
                //设置当前用户信息
                [Common setUser:user];
                [self.rootView showTabByTag:TYPE_ISBIND_PHONE];
                //TD
                [TalkingDataAppCpa onRegister:user.user_id];
            } else {
                [self showToast:code];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

/*
 * 返回
 */
- (void)backBtnClick
{
    [self.rootView showTabByTag:TYPE_LOGIN];
}

#pragma mark - resetView
- (void)resetView
{
    _accountField.text = @"";
    _passWordField.text = @"";
    _surePassWordField.text = @"";
    
    [_accountField resignFirstResponder];
    [_passWordField resignFirstResponder];
    [_surePassWordField resignFirstResponder];
}

@end
