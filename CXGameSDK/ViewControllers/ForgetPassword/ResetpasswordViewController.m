//
//  ResetpasswordViewController.m
//  CXGameSDK
//
//  Created by NaNa on 14-10-21.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "ResetpasswordViewController.h"

@interface ResetpasswordViewController () {
    UITextField *_codeField;
    UITextField *_passwordField;
    NSString    *_username;
    NSString    *_codeNumber;
    NSString    *_newPassword;
    UIButton    *_getCodeBtn;
    NSString    *_countDownTime;
}

@end

@implementation ResetpasswordViewController

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

#pragma mark - setUpSubViews
- (void)setUpSubViews
{
    //set codeView
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(26, 92, 84, 27)];
    [codeView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:codeView];
    
    //set codeBackgroundView
    UIImageView *codeBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 84, 27)];
    [codeBackView setImage:[UIImage imageNamed:@"CXshuruyanzhengma"]];
    [codeView addSubview:codeBackView];
    
    //set codeTextField
    _codeField = [[UITextField alloc] initWithFrame:CGRectMake(3, 7, 78, 14)];
    [_codeField setPlaceholder:@"请输入验证码"];
    [_codeField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_codeField setFont:[UIFont systemFontOfSize:13.0]];
    [_codeField setTextColor:[UIColor whiteColor]];
    _codeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_codeField setReturnKeyType:UIReturnKeyDone];
    _codeField.delegate = self;
    [codeView addSubview:_codeField];
    
    //set getCodeBtn
    _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 92, 84, 27)];
    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [_getCodeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getCodeBtn];
    
    //set newPasswordView
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(26, 130, 177, 27)];
    [passwordView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:passwordView];
    
    //set newPasswordBackgroundView
    UIImageView *passwordBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [passwordBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [passwordView addSubview:passwordBackView];
    
    //set newPasswordImgView
    UIImageView *passwordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [passwordImgView setImage:[UIImage imageNamed:@"CXmima"]];
    [passwordView addSubview:passwordImgView];
    
    //set newPasswordTextField
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 130, 14)];
    [_passwordField setPlaceholder:@"请输入修改后的密码"];
    [_passwordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordField setFont:[UIFont systemFontOfSize:13.0]];
    [_passwordField setTextColor:[UIColor whiteColor]];
    _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passwordField setReturnKeyType:UIReturnKeyDone];
    _passwordField.delegate = self;
    [passwordView addSubview:_passwordField];
    
    //set beginBtn
    UIButton *beginBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 163, 84, 27)];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateNormal];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateHighlighted];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [beginBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
    
    //set backBtn
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 163, 84, 27)];
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
    //set codeView
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(29, 112, 107, 35)];
    [codeView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:codeView];
    
    //set codeBackgroundView
    UIImageView *codeBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 107, 35)];
    [codeBackView setImage:[UIImage imageNamed:@"CXshuruyanzhengma"]];
    [codeView addSubview:codeBackView];
    
    //set codeTextField
    _codeField = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, 90, 15)];
    [_codeField setPlaceholder:@"请输入验证码"];
    [_codeField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_codeField setFont:[UIFont systemFontOfSize:15.0]];
    [_codeField setTextColor:[UIColor whiteColor]];
    _codeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_codeField setReturnKeyType:UIReturnKeyDone];
    _codeField.delegate = self;
    [codeView addSubview:_codeField];
    
    //set getCodeBtn
    _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 112, 107, 35)];
    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [_getCodeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getCodeBtn];
    
    //set passwordView
    UIView *passwordView = [[UIView alloc] initWithFrame:CGRectMake(29, 160, 228, 35)];
    [passwordView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:passwordView];
    
    //set passwordBackgroundView
    UIImageView *passwordBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [passwordBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [passwordView addSubview:passwordBackView];
    
    //set passwordImgView
    UIImageView *passwordImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [passwordImgView setImage:[UIImage imageNamed:@"padMima"]];
    [passwordView addSubview:passwordImgView];
    
    //set passwordTextField
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 150, 15)];
    [_passwordField setPlaceholder:@"请输入修改后的密码"];
    [_passwordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordField setFont:[UIFont systemFontOfSize:15.0]];
    [_passwordField setTextColor:[UIColor whiteColor]];
    _passwordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passwordField setReturnKeyType:UIReturnKeyDone];
    _passwordField.delegate = self;
    [passwordView addSubview:_passwordField];
    
    //set beginBtn
    UIButton *beginBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 204, 107, 35)];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateNormal];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateHighlighted];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [beginBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
    
    //set backBtn
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 204, 107, 35)];
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

/**
 *  倒计时60秒
 */
- (void)countdown
{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<=0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
                    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
                } else {
                    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
                    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
                }
                [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
                [_getCodeBtn setUserInteractionEnabled:YES];
            });
        } else {
            int seconds = timeout % 60;
            _countDownTime = [NSString stringWithFormat:@"%.2ds重新获取", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
                    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
                } else {
                    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
                    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
                }
                [_getCodeBtn setTitle:_countDownTime forState:UIControlStateNormal];
                [_getCodeBtn setTitle:_countDownTime forState:UIControlStateHighlighted];
                [_getCodeBtn setUserInteractionEnabled:NO];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark - UIButtonClick
/**
 *  获取验证码
 */
- (void)getCodeBtnClick
{
   _username = [[NSUserDefaults standardUserDefaults] objectForKey:@"pUserName"];
    
    NSDictionary *dic = @{@"username": _username};
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"user/sendforgetpwdcode" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if(code == 1){
                //发送回调
                [SVProgressHUD showSuccessWithStatus:@"验证码将通过手机短信的形式发送给您"];
                [self countdown];
            } else {
                [self showToast:code];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

/**
 *  进入游戏
 */
- (void)beginBtnClick
{
    [_codeField resignFirstResponder]; //关闭输入法键盘
    [_passwordField resignFirstResponder]; //关闭输入法键盘
    _codeNumber = _codeField.text;
    _newPassword = _passwordField.text;
    _username = [[NSUserDefaults standardUserDefaults] objectForKey:@"pUserName"];

    if ([StringUtil isEmpty:_codeNumber]) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        return;
    }
    if ([StringUtil isEmpty:_newPassword]) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    }
    
    NSDictionary *dic = @{@"username": _username,
                          @"code": _codeNumber,
                          @"new_pwd": _newPassword
                          };

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"user/resetpwd" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if (code == 1) {
                //发送回调
                UserModel *user = [Common getUser];
                user.username = _username;
                user.password =_newPassword;
                [self saveUsers:user];
                [Common setUser:user];
                
                [self.rootView closeSDK];
            } else {
                [self showToast:code];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

/**
 *  返回
 */
- (void)backBtnClick
{
    [self.rootView showTabByTag:TYPE_FORGOT_PASSWORD];
}

@end
