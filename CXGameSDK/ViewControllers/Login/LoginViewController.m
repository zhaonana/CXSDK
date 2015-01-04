
//
//  LoginViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "PreferencesUtils.h"
#import "CXSDKViewController.h"
#import "OtherLoginViewController.h"
#import "TalkingDataAppCpa.h"
#import "BaseNavigationController.h"

@interface LoginViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITextField    *_accountField;
    UITextField    *_passWordField;
    NSMutableArray *_userArray;
    UITableView    *_tableView;
    UIButton       *_forgotBtn;
    UILabel        *_forgetLab;
    NSMutableArray *_dataArray;
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - setUpSubViews
- (void)setUpSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(26, 58, 177, 27)];
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
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 126, 14)];
    [_accountField setPlaceholder:@"请输入账号"];
    [_accountField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setFont:[UIFont systemFontOfSize:13.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set switchBtn
    UIImageView *switchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(156, 6, 15, 15)];
    [switchImgView setImage:[UIImage imageNamed:@"CXxiala"]];
    [accountView addSubview:switchImgView];
    
    UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 0, 27, 27)];
    [switchBtn addTarget:self action:@selector(switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:switchBtn];
    
    //set passWordView
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(26, 92, 177, 27)];
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
    _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passWordField setReturnKeyType:UIReturnKeyDone];
    _passWordField.secureTextEntry = YES;
    _passWordField.delegate = self;
    [passWordView addSubview:_passWordField];
    
    //set accountField and passwordField
    [self setUpAccountFieldAndPasswordField];
    
    //set loginBtn
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 130, 84, 27)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登录游戏" forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录游戏" forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //set touristsBtn
    UIButton *touristsBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 130, 84, 27)];
    [touristsBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
    [touristsBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
    [touristsBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    [touristsBtn setTitle:@"游客登录" forState:UIControlStateHighlighted];
    [touristsBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [touristsBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [touristsBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [touristsBtn addTarget:self action:@selector(touristsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touristsBtn];
    
    //set registBtn
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 163, 177, 27)];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"CXzhuce"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"CXzhuce"] forState:UIControlStateHighlighted];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitle:@"注册" forState:UIControlStateHighlighted];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    //set otherLoginLab
    UILabel *otherLab = [[UILabel alloc] initWithFrame:CGRectMake(38, 213, 63, 13)];
    [otherLab setText:@"其他登陆:"];
    [otherLab setFont:[UIFont systemFontOfSize:14.0]];
    [otherLab setTextColor:[UIColor whiteColor]];
    [self.view addSubview:otherLab];
    
    //set sinaBtn
    UIButton *sinaBtn = [[UIButton alloc] initWithFrame:CGRectMake(104, 205, 29, 28)];
    [sinaBtn setImage:[UIImage imageNamed:@"CXweibo"] forState:UIControlStateNormal];
    [sinaBtn setImage:[UIImage imageNamed:@"CXweibo"] forState:UIControlStateHighlighted];
    [sinaBtn addTarget:self action:@selector(sinaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaBtn];
    
    //set tencentBtn
//    UIButton *tencentBtn = [[UIButton alloc] initWithFrame:CGRectMake(143, 205, 29, 28)];
//    if ([QQApi isQQInstalled]) {
//        [tencentBtn setImage:[UIImage imageNamed:@"CXqq"] forState:UIControlStateNormal];
//        [tencentBtn setImage:[UIImage imageNamed:@"CXqq"] forState:UIControlStateHighlighted];
//    } else {
//        [tencentBtn setImage:[UIImage imageNamed:@"CXqqhui"] forState:UIControlStateNormal];
//        [tencentBtn setImage:[UIImage imageNamed:@"CXqqhui"] forState:UIControlStateHighlighted];
//    }
//    [tencentBtn addTarget:self action:@selector(tencentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:tencentBtn];
    
    //set forgotPassWordBtn
    _forgotBtn = [[UIButton alloc] initWithFrame:CGRectMake(144, 246, 64, 13)];
    [_forgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotBtn setTitle:@"忘记密码?" forState:UIControlStateHighlighted];
    [_forgotBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_forgotBtn addTarget:self action:@selector(forgotPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgotBtn];
    
    //set forgetLab
    _forgetLab = [[UILabel alloc] initWithFrame:CGRectMake(143, 260, 65, 1)];
    [self.view addSubview:_forgetLab];
    
    //set forgotPassWordBtn and forgetLab state
    [self setUpForgotPasswordBtnWithOrigin:[Common getUser].origin];
    
    //set switchTableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(26, 85, 177, 0) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)setUpPadSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(29, 70, 228, 35)];
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
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 162, 15)];
    [_accountField setPlaceholder:@"请输入账号"];
    [_accountField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setFont:[UIFont systemFontOfSize:15.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.userInteractionEnabled = NO;
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set switchBtn
    UIImageView *switchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 8, 18, 18)];
    [switchImgView setImage:[UIImage imageNamed:@"padXiala"]];
    [accountView addSubview:switchImgView];
    
    UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(193, 0, 35, 35)];
    [switchBtn addTarget:self action:@selector(switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:switchBtn];

    //set passWordView
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(29, 114, 228, 35)];
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
    _passWordField.userInteractionEnabled = NO;
    _passWordField.delegate = self;
    [passWordView addSubview:_passWordField];
    
    //set accountField and passwordField
    [self setUpAccountFieldAndPasswordField];
    
    //set loginBtn
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 162, 107, 35)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登录游戏" forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录游戏" forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //set touristsBtn
    UIButton *touristsBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 162, 107, 35)];
    [touristsBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
    [touristsBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
    [touristsBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    [touristsBtn setTitle:@"游客登录" forState:UIControlStateHighlighted];
    [touristsBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [touristsBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [touristsBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [touristsBtn addTarget:self action:@selector(touristsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touristsBtn];
    
    //set registBtn
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 206, 228, 35)];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"padZhuce"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"padZhuce"] forState:UIControlStateHighlighted];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitle:@"注册" forState:UIControlStateHighlighted];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    //set otherLoginLab
    UILabel *otherLab = [[UILabel alloc] initWithFrame:CGRectMake(54, 270, 70, 16)];
    [otherLab setText:@"其他登陆:"];
    [otherLab setFont:[UIFont systemFontOfSize:16.0]];
    [otherLab setTextColor:[UIColor whiteColor]];
    [self.view addSubview:otherLab];
    
    //set sinaBtn
    UIButton *sinaBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 264, 31, 31)];
    [sinaBtn setImage:[UIImage imageNamed:@"padWeibo"] forState:UIControlStateNormal];
    [sinaBtn setImage:[UIImage imageNamed:@"padWeibo"] forState:UIControlStateHighlighted];
    [sinaBtn addTarget:self action:@selector(sinaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaBtn];
    
    //set tencentBtn
//    UIButton *tencentBtn = [[UIButton alloc] initWithFrame:CGRectMake(174, 264, 31, 31)];
//    if ([QQApi isQQInstalled]) {
//        [tencentBtn setImage:[UIImage imageNamed:@"padQq"] forState:UIControlStateNormal];
//        [tencentBtn setImage:[UIImage imageNamed:@"padQq"] forState:UIControlStateHighlighted];
//    } else {
//        [tencentBtn setImage:[UIImage imageNamed:@"padQqhui"] forState:UIControlStateNormal];
//        [tencentBtn setImage:[UIImage imageNamed:@"padQqhui"] forState:UIControlStateHighlighted];
//    }
//    [tencentBtn addTarget:self action:@selector(tencentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:tencentBtn];
    
    //set forgotPassWordBtn
    _forgotBtn = [[UIButton alloc] initWithFrame:CGRectMake(178, 310, 74, 16)];
    [_forgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgotBtn setTitle:@"忘记密码?" forState:UIControlStateHighlighted];
    [_forgotBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [_forgotBtn addTarget:self action:@selector(forgotPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgotBtn];
    
    //set forgetLab
    _forgetLab = [[UILabel alloc] initWithFrame:CGRectMake(176, 326, 74, 1)];
    [_forgetLab setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_forgetLab];
    
    //set forgotPassWordBtn and forgetLab state
    [self setUpForgotPasswordBtnWithOrigin:[Common getUser].origin];

    //set switchTableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(29, 105, 228, 0) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)setUpForgotPasswordBtnWithOrigin:(NSString *)origin
{
    if ([origin integerValue] == 1 || [origin integerValue] == 2) {
        [_forgotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_forgotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _forgotBtn.userInteractionEnabled = NO;
        [_forgetLab setBackgroundColor:[UIColor grayColor]];
        _accountField.textColor = [UIColor colorWithRed:90.0/255.0 green:167.0/255.0 blue:225.0/255.0 alpha:1.0];
    } else {
        [_forgotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_forgotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _forgotBtn.userInteractionEnabled = YES;
        [_forgetLab setBackgroundColor:[UIColor whiteColor]];
        _accountField.textColor = [UIColor whiteColor];
    }
}

- (void)setUpAccountFieldAndPasswordField
{
    if (_accountField.text.length) {
        [_passWordField setTextColor:[UIColor grayColor]];
        _accountField.userInteractionEnabled = NO;
        _passWordField.userInteractionEnabled = NO;
    } else {
        [_passWordField setTextColor:[UIColor whiteColor]];
        _accountField.userInteractionEnabled = YES;
        _passWordField.userInteractionEnabled = YES;
    }
}

- (void)initView
{
    NSString *save = [PreferencesUtils getStringForKey:kSaveUser];
    if ([StringUtil isEmpty:save]) {
        save = @"1";
    }
    
    NSString *json = [PreferencesUtils getStringForKey:kUserNames];
    if([StringUtil isNotEmpty:json]){
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *userArray = [JsonUtil parseUserModelArrayStr:[self parseJsonData:data]];
        
        if(userArray && [userArray count] > 0){
            UserModel *lastUser = [userArray objectAtIndex:userArray.count - 1];
            NSString *nick_name = lastUser.nick_name;
            NSString *password = lastUser.password;
            if ([save isEqualToString:@"0"]) {
                _accountField.text = nick_name;
                _passWordField.text = password;
            }
            
            [Common setUser:lastUser];
        }
    }
}

/**
 *  设置下拉菜单显示
 */
- (void)showSwitchTableView
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (_dataArray.count < 6) {
            [_tableView setFrame:CGRectMake(26, 85, 177, 27 * _dataArray.count)];
        } else {
            [_tableView setFrame:CGRectMake(26, 85, 177, 135)];
        }
    } else {
        if (_dataArray.count < 6) {
            [_tableView setFrame:CGRectMake(29, 105, 228, 35 * _dataArray.count)];
        } else {
            [_tableView setFrame:CGRectMake(29, 105, 228, 175)];
        }
    }
}

/**
 *  设置下拉菜单隐藏
 */
- (void)hiddenSwitchTableView
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [_tableView setFrame:CGRectMake(26, 85, 177, 0)];
    } else {
        [_tableView setFrame:CGRectMake(29, 105, 228, 0)];
    }
}

/**
 *  设置键盘消失
 */
- (void)setKeyBoardHidden
{
    [_accountField resignFirstResponder];
    [_passWordField resignFirstResponder];
}

#pragma mark - UIButtonClick
/**
 *  切换账户
 */
- (void)switchBtnClick
{
    [self setKeyBoardHidden];
    
    NSString *json = [PreferencesUtils getStringForKey:kUserNames];
    if ([StringUtil isEmpty:json]) {
        json = @"";
    }
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    _userArray = [JsonUtil parseUserModelArrayStr:[self parseJsonData:data]];
    if (_userArray && _userArray.count > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            if (_tableView.bounds.size.height == 0) {
                [self showSwitchTableView];
            } else {
                [self hiddenSwitchTableView];
            }
        } completion:^(BOOL finished) {
            
        }];
        [_tableView reloadData];
    } else {
        [SVProgressHUD showErrorWithStatus:@"没有其他账户"];
    }
    
    _dataArray = [[NSMutableArray alloc] initWithArray:_userArray];
    UserModel *user = [[UserModel alloc] init];
    user.nick_name = @"其他用户";
    [_dataArray addObject:user];
}

/**
 *  登录游戏
 */
- (void)loginBtnClick
{
    NSLog(@"登录游戏");
    
    [self setKeyBoardHidden];
    
    NSString *username = [Common getUser].username;
    NSString *password = [Common getUser].password;
    NSString *origin = [Common getUser].origin;
    NSString *userid = nil;
    
    if (_accountField.userInteractionEnabled == YES) {
        if([StringUtil isEmpty:_accountField.text]) {
            [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
            return;
        }
        
        if([StringUtil isEmpty:_passWordField.text]) {
            [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
            return;
        }
        username = _accountField.text;
        password = _passWordField.text;
        origin = @"0";
        userid = @"";
    } else {
        userid = [Common getUser].user_id;
    }
    
    NSDictionary *dic = @{@"username": username,
                          @"password": password,
                          @"origin": origin,
                          @"user_id": userid
                          };

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    [GGNetWork getHttp:@"user/login" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if(code == 1){                
                NSDictionary *dic = [responseObj objectForKey:@"data"];
                UserModel *user = [JsonUtil parseUserModel:dic];
                user.username = username;
                user.password = password;
                user.origin = origin;
                
                //保存账户密码
                [self saveUsers:user];
                //设置当前用户信息
                [Common setUser:user];
                [self.rootView closeSDK];
                //TD
                [TalkingDataAppCpa onLogin:user.user_id];
            } else {
                NSDictionary *dic = @{@"code": [NSString stringWithFormat:@"%ld",(long)code]};
                [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAILED_NOTIFICATION object:nil userInfo:dic];
                [self showToast:code];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

/**
 *  游客登陆
 */
- (void)touristsBtnClick
{
    NSLog(@"游客登陆");
    [self.rootView showTabByTag:TYPE_TOURISTS_LOGIN];
}

/**
 *  注册
 */
- (void)registBtnClick
{
    NSLog(@"注册");
    [self.rootView showTabByTag:TYPE_REGISTER];
}

/**
 *  忘记密码
 */
- (void)forgotPasswordBtnClick
{
    NSLog(@"忘记密码");
    [[NSUserDefaults standardUserDefaults] setObject:_accountField.text forKey:@"pUserName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.rootView showTabByTag:TYPE_FORGOT_PASSWORD];
}

/**
 *  新浪登陆
 */
- (void)sinaBtnClick
{
    NSLog(@"新浪登陆");
    
    OtherLoginViewController *olVct = [[OtherLoginViewController alloc] init];
    olVct.client = @"sina";
    olVct.cancelOtherLoginBlock = ^() {
        [self.rootView showSDK];
    };
    olVct.loginSuccessedBlock = ^(NSString *user_id, NSString *ticket) {
        NSDictionary *dic = @{@"user_id": user_id,
                              @"ticket": ticket
                              };
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCCESSED_NOTIFICATION object:nil userInfo:dic];
    };
    
    BaseNavigationController *nc = [[BaseNavigationController alloc] initWithRootViewController:olVct];
    [self.rootView.controller presentViewController:nc animated:YES completion:^{
        [self.rootView hiddenSDK];
    }];

//    if (![WeiboSDK isWeiboAppInstalled]) {
//        [self.rootView closeSDK];
//    } 
//    if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo]) {
//        [self.rootView closeSDK];
//    } else {
//        [ShareSDK authWithType:ShareTypeSinaWeibo options:[ShareSDK authOptionsWithAutoAuth:YES allowCallback:YES scopes:nil powerByHidden:YES followAccounts:nil authViewStyle:SSAuthViewStyleFullScreenPopup viewDelegate:nil authManagerViewDelegate:nil] result:^(SSAuthState state, id<ICMErrorInfo> error) {
//            if (state == SSAuthStateSuccess) {
//                NSLog(@"授权成功~");
//                [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
//                    if (result) {
//                        [self otherLoginRequestWithClient:@"SinaWeibo" nickname:[userInfo nickname] uid:[userInfo uid]];
//                    }
//                }];
//            } else if (state == SSAuthStateFail) {
//                NSLog(@"授权失败~");
//            }
//        }];
//    }
}

/**
 *  腾讯登陆
 */
- (void)tencentBtnClick
{
    NSLog(@"腾讯登陆");
//    OtherLoginViewController *olVct = [[OtherLoginViewController alloc] init];
//    olVct.client = @"QQ";
//    [self.rootView.controller presentViewController:olVct animated:YES completion:^{
//        [self.rootView closeSDK];
//    }];
//    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
//        if (result) {
//            [self otherLoginRequestWithClient:@"QQ" nickname:[userInfo nickname] uid:[userInfo uid]];
//        } 
//    }];
}

//- (void)otherLoginRequestWithClient:(NSString *)client nickname:(NSString *)nickname uid:(NSString *)uid
//{
//    NSDictionary *dic = @{@"channel": @"ios",
//                          @"client": client,
//                          @"nick_name": nickname,
//                          @"u_id": uid
//                          };
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
//    [GGNetWork getHttp:@"user/rollbacks" parameters:params sucess:^(id responseObj) {
//        if (responseObj) {
//            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
//            if(code == 1){
//                NSDictionary *dic = [responseObj objectForKey:@"data"];
//                UserModel *user = [JsonUtil parseUserModel:dic];
//                
//                if (self.rootView.loginDelegate && [self.rootView.loginDelegate respondsToSelector:@selector(loginSuccessedCallBack:userID:ticket:)]) {
//                    [self.rootView.loginDelegate loginSuccessedCallBack:code userID:user.user_id ticket:user.ticket];
//                }
//                
//                //保存账户密码
//                [self saveUsers:user];
//                //设置当前用户信息
//                [Common setUser:user];
//                //关闭SDK
//                [self.rootView closeSDK];
//            } else {
//                if (self.rootView.loginDelegate && [self.rootView.loginDelegate respondsToSelector:@selector(loginFailedCallBack:)]) {
//                    [self.rootView.loginDelegate loginFailedCallBack:code];
//                }
//                [self showToast:code];
//            }
//        }
//    } failed:^(NSString *errorMsg) {
//        [SVProgressHUD showErrorWithStatus:@"链接失败"];
//    }];
//}

#pragma mark - resetView
- (void)resetView
{
    if ([Common getUser]) {
        _accountField.text = [Common getUser].nick_name;
        _passWordField.text = [Common getUser].password;
    }
    
    //set forgotPassWordBtn and forgetLab state
    [self setUpForgotPasswordBtnWithOrigin:[Common getUser].origin];
    //set accountField and passwordField
    [self setUpAccountFieldAndPasswordField];
    
    [self setKeyBoardHidden];
}

- (void)showUpdatePassword
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改密码" message:@"快速登录账户，需要修改密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UserModel *user = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = user.nick_name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return 27.0;
    } else {
        return 35.0;
    }
    return 0.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setKeyBoardHidden];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self hiddenSwitchTableView];
    } completion:^(BOOL finished) {
        
    }];
    UserModel *user = [_dataArray objectAtIndex:indexPath.row];
    if ([user.nick_name isEqualToString:@"其他用户"]) {
        _accountField.text = @"";
        _passWordField.text = @"";
        _accountField.userInteractionEnabled = YES;
        _passWordField.userInteractionEnabled = YES;
        _passWordField.textColor = [UIColor whiteColor];
    } else {
        _accountField.text = user.nick_name;
        _passWordField.text = user.password;
        _accountField.userInteractionEnabled = NO;
        _passWordField.userInteractionEnabled = NO;
        _passWordField.textColor = [UIColor grayColor];
        [Common setUser:user];
        [Common setBindPhone:NO];
    }
    
    //set forgotPassWordBtn and forgetLab state
    [self setUpForgotPasswordBtnWithOrigin:user.origin];
    [tableView reloadData];
}

@end
