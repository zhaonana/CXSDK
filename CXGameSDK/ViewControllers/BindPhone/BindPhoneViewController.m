//
//  BindPhoneViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "SVProgressHUD.h"
#import "StringUtil.h"
#import "GGNetWork.h"
#import "PreferencesUtils.h"
#import "Common.h"
#import "JsonUtil.h"
#import "PreferencesUtils.h"

@interface BindPhoneViewController () {
    UITextField *_phoneField;
    UITextField *_codeField;
    NSString    *_phoneNumber;
    NSString    *_codeNumber;
    UIButton    *_getCodeBtn;
    NSString    *_countDownTime;
}

@end

@implementation BindPhoneViewController

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
    NSString *json = [PreferencesUtils getStringForKey:kUserNames];
    if ([StringUtil isNotEmpty:json]) {
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *_userArray = [JsonUtil parseUserModelArrayStr:[self parseJsonData:data]];
        if(_userArray && _userArray.count > 0){
            [Common setUser:[_userArray objectAtIndex:_userArray.count - 1]];
        }
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
    //set phoneView
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(26, 92, 177, 27)];
    [phoneView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:phoneView];
    
    //set phoneBackgroundView
    UIImageView *phoneBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [phoneBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [phoneView addSubview:phoneBackView];
    
    //set phoneImgView
    UIImageView *phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [phoneImgView setImage:[UIImage imageNamed:@"CXdianhua"]];
    [phoneView addSubview:phoneImgView];
    
    //set phoneTextField
    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 130, 14)];
    [_phoneField setPlaceholder:@"请输入手机号码"];
    [_phoneField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneField setFont:[UIFont systemFontOfSize:13.0]];
    [_phoneField setTextColor:[UIColor whiteColor]];
    _phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_phoneField setReturnKeyType:UIReturnKeyDone];
    _phoneField.delegate = self;
    [phoneView addSubview:_phoneField];
    
    //set codeView
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(26, 130, 84, 27)];
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
    _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 130, 84, 27)];
    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [_getCodeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [_getCodeBtn setUserInteractionEnabled:YES];
    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getCodeBtn];
    
    //set bindBtn
    UIButton *bindBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 163, 84, 27)];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateHighlighted];
    [bindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [bindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [bindBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [bindBtn addTarget:self action:@selector(bindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindBtn];
    
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
    
    //set alertLab
    UILabel *alertLab = [[UILabel alloc] initWithFrame:CGRectMake(48, 200, 130, 27)];
    [alertLab setBackgroundColor:[UIColor clearColor]];
    [alertLab setText:@"绑定手机保障账号安全"];
    [alertLab setFont:[UIFont systemFontOfSize:13.0]];
    [alertLab setTextColor:[UIColor whiteColor]];
    [self.view addSubview:alertLab];
}

- (void)setUpPadSubViews
{
    //set phoneView
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(29, 112, 228, 35)];
    [phoneView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:phoneView];
    
    //set phoneBackgroundView
    UIImageView *phoneBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [phoneBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [phoneView addSubview:phoneBackView];
    
    //set phoneImgView
    UIImageView *phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [phoneImgView setImage:[UIImage imageNamed:@"padDianhua"]];
    [phoneView addSubview:phoneImgView];
    
    //set phoneTextField
    _phoneField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 150, 15)];
    [_phoneField setPlaceholder:@"请输入手机号码"];
    [_phoneField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneField setFont:[UIFont systemFontOfSize:15.0]];
    [_phoneField setTextColor:[UIColor whiteColor]];
    _phoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_phoneField setReturnKeyType:UIReturnKeyDone];
    _phoneField.delegate = self;
    [phoneView addSubview:_phoneField];
    
    //set codeView
    UIView *codeView = [[UIView alloc] initWithFrame:CGRectMake(29, 160, 107, 35)];
    [codeView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:codeView];
    
    //set codeBackgroundView
    UIImageView *codeBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 107, 35)];
    [codeBackView setImage:[UIImage imageNamed:@"padShuruyanzhengma"]];
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
    _getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 160, 107, 35)];
    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
    [_getCodeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [_getCodeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [_getCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [_getCodeBtn setUserInteractionEnabled:YES];
    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getCodeBtn];
    
    //set bindBtn
    UIButton *bindBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 204, 107, 35)];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateHighlighted];
    [bindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [bindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [bindBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [bindBtn addTarget:self action:@selector(bindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindBtn];
    
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
    
    //set alertLab
    UILabel *alertLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 250, 160, 35)];
    [alertLab setBackgroundColor:[UIColor clearColor]];
    [alertLab setText:@"绑定手机保障账号安全"];
    [alertLab setFont:[UIFont systemFontOfSize:15.0]];
    [alertLab setTextColor:[UIColor whiteColor]];
    [self.view addSubview:alertLab];
}

#pragma mark - UIButtonClick
/**
 *  返回
 */
- (void)backBtnClick
{
    [self.rootView showTabByTag:TYPE_USER_LOGIN];
}

/**
 *  获取验证码
 */
- (void)getCodeBtnClick
{
    [_phoneField resignFirstResponder]; //关闭输入法键盘
    [_codeField resignFirstResponder]; //关闭输入法键盘
    _phoneNumber = _phoneField.text;
    
    if([StringUtil isEmpty:_phoneNumber]){
        [SVProgressHUD showErrorWithStatus:@"手机号码不能为空"];
        return;
    }
    if (![PreferencesUtils isValidateMobile:_phoneNumber]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    NSDictionary *dic = @{@"user_id": [Common getUser].user_id,
                         @"phone": _phoneNumber
                         };
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"user/bindmobilesendcode" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if (code == 1) {
                //发送回调
                [SVProgressHUD showSuccessWithStatus:@"验证码已发送，请稍等"];
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

/**
 *  立即绑定
 */
- (void)bindBtnClick
{
    [_phoneField resignFirstResponder]; //关闭输入法键盘
    [_codeField resignFirstResponder]; //关闭输入法键盘
    _codeNumber = _codeField.text;
    _phoneNumber = _phoneField.text;
    
    if ([StringUtil isEmpty:_codeNumber]) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空"];
        return;
    }
    NSDictionary *dic = @{@"user_id": [Common getUser].user_id,
                          @"code": _codeNumber,
                          @"phone": _phoneNumber
                          };

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"user/bindmobile" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if (code == 1) {
                //发送回调
                [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
                [Common setBindPhone:YES];
                [self.rootView showTabByTag:TYPE_USER_LOGIN];
            } else {
                [self showToast:code];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

#pragma mark - resetView
- (void)resetView
{
    _phoneField.text = @"";
    _codeField.text = @"";
    
    [_phoneField resignFirstResponder];
    [_codeField resignFirstResponder];
    
    NSString *json = [PreferencesUtils getStringForKey:kUserNames];
    if ([StringUtil isNotEmpty:json]) {
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *_userArray = [JsonUtil parseUserModelArrayStr:[self parseJsonData:data]];
        if(_userArray && _userArray.count > 0){
            [Common setUser:[_userArray objectAtIndex:_userArray.count - 1]];
        }
    }
}


@end
