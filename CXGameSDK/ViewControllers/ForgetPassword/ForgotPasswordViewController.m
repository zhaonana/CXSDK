//
//  ForgotPasswordViewController.m
//  BXGameSDK
//
//  Created by JZY on 14-2-19.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "PreferencesUtils.h"

@interface ForgotPasswordViewController () {
    UITextField    *_accountField;
    NSString       *_username;
    NSMutableArray *_userArray;
    UITableView    *_tableView;
    UILabel        *_isBindPhoneLab;
}

@end

@implementation ForgotPasswordViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_isBindPhoneLab setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setUpSubViews
- (void)setUpSubViews
{
    //setisBindPhoneLab
    _isBindPhoneLab = [[UILabel alloc] initWithFrame:CGRectMake(26, 68, 177, 54)];
    [_isBindPhoneLab setText:@"未绑定手机号，通过联系客服QQ找回密码1489595180"];
    [_isBindPhoneLab setFont:[UIFont systemFontOfSize:13.0]];
    [_isBindPhoneLab setNumberOfLines:0];
    [_isBindPhoneLab setTextColor:[UIColor redColor]];
    [_isBindPhoneLab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_isBindPhoneLab];
    [_isBindPhoneLab setHidden:YES];
    
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(26, 118, 177, 27)];
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
    [_accountField setPlaceholder:@"请输入账号"];
    [_accountField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setFont:[UIFont systemFontOfSize:13.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.userInteractionEnabled = NO;
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set sendBtn
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 173, 84, 27)];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [sendBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [sendBtn setTitle:@"下一步" forState:UIControlStateHighlighted];
    [sendBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [sendBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    //set backBtn
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 173, 84, 27)];
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
    //setisBindPhoneLab
    _isBindPhoneLab = [[UILabel alloc] initWithFrame:CGRectMake(29, 78, 228, 70)];
    [_isBindPhoneLab setText:@"未绑定手机号，通过联系客服QQ找回密码1489595180"];
    [_isBindPhoneLab setFont:[UIFont systemFontOfSize:15.0]];
    [_isBindPhoneLab setNumberOfLines:0];
    [_isBindPhoneLab setTextColor:[UIColor redColor]];
    [_isBindPhoneLab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_isBindPhoneLab];
    [_isBindPhoneLab setHidden:YES];
    
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(29, 138, 228, 35)];
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
    [_accountField setPlaceholder:@"请输入账号"];
    [_accountField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setFont:[UIFont systemFontOfSize:15.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.userInteractionEnabled = NO;
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set sendBtn
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 202, 107, 35)];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [sendBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [sendBtn setTitle:@"下一步" forState:UIControlStateHighlighted];
    [sendBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [sendBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    //set backBtn
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 202, 107, 35)];
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

#pragma mark - resetView
- (void)resetView
{
    _username = [[NSUserDefaults standardUserDefaults] objectForKey:@"pUserName"];
    _accountField.text = _username;
    
    [_accountField resignFirstResponder];
}

#pragma mark - UIButtonClick
/**
 *  发送验证码到手机
 */
- (void)sendBtnClick
{
    [_accountField resignFirstResponder];

    _username = [[NSUserDefaults standardUserDefaults] objectForKey:@"pUserName"];
    
    NSDictionary *dic = @{@"username": _username,
                          };
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"user/isbindmobile" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if(code == 1){
                [_isBindPhoneLab setHidden:YES];
                [[NSUserDefaults standardUserDefaults] setObject:_username forKey:@"pUserName"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.rootView showTabByTag:TYPE_RESET_PASSWORD];
            } else {
                [_isBindPhoneLab setHidden:NO];
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
    [self.rootView showTabByTag:TYPE_LOGIN];
}

@end
