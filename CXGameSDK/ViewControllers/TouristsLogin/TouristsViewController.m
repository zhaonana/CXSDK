//
//  TouristsViewController.m
//  CXGameSDK
//
//  Created by NaNa on 14-10-16.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "TouristsViewController.h"
#import <MessageUI/MessageUI.h>
#import "TalkingDataAppCpa.h"

@interface TouristsViewController () <MFMessageComposeViewControllerDelegate, UIAlertViewDelegate> {
    UITextField *_accountField;
    UITextField *_passWordField;
    NSString    *_username;
    NSString    *_password;
}

@end

@implementation TouristsViewController

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
    //生成随机账户
    [self initAccount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setUpSubViews
- (void)setUpSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(26, 78, 177, 27)];
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
    [_accountField setFont:[UIFont systemFontOfSize:13.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.userInteractionEnabled = NO;
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set sendBtn
    UIImageView *switchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(156, 6, 15, 15)];
    [switchImgView setImage:[UIImage imageNamed:@"CXduanxintongzhi"]];
    [accountView addSubview:switchImgView];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 0, 27, 27)];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:sendBtn];
    
    //set passWordView
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(26, 112, 177, 27)];
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
    [_passWordField setFont:[UIFont systemFontOfSize:13.0]];
    [_passWordField setTextColor:[UIColor whiteColor]];
    _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passWordField setReturnKeyType:UIReturnKeyDone];
    _passWordField.userInteractionEnabled = NO;
    _passWordField.delegate = self;
    [passWordView addSubview:_passWordField];
    
    //set registBtn
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 150, 84, 27)];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [registBtn setTitle:@"注册新账号" forState:UIControlStateNormal];
    [registBtn setTitle:@"注册新账号" forState:UIControlStateHighlighted];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    //set changeBtn
    UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 150, 84, 27)];
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
    [changeBtn setTitle:@"切换账号" forState:UIControlStateNormal];
    [changeBtn setTitle:@"切换账号" forState:UIControlStateHighlighted];
    [changeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [changeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [changeBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    //set beginBtn
    UIButton *beginBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 183, 177, 27)];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"CXzhuce"] forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"CXzhuce"] forState:UIControlStateHighlighted];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateNormal];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateHighlighted];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [beginBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
    
    //set messageLab
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(48, 220, 27, 27)];
    [messageLab setText:@"点击"];
    [messageLab setFont:[UIFont systemFontOfSize:13.0]];
    [messageLab setTextColor:[UIColor whiteColor]];
    [messageLab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:messageLab];
    
    //set messageImgView
    UIImageView *messageImgView = [[UIImageView alloc] initWithFrame:CGRectMake(75, 227, 15, 15)];
    [messageImgView setImage:[UIImage imageNamed:@"CXduanxintongzhi"]];
    [self.view addSubview:messageImgView];
    
    //set lastLab
    UILabel *lastLab = [[UILabel alloc] initWithFrame:CGRectMake(91, 220, 93, 27)];
    [lastLab setText:@"保存账号到手机"];
    [lastLab setFont:[UIFont systemFontOfSize:13.0]];
    [lastLab setTextColor:[UIColor whiteColor]];
    [lastLab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lastLab];
}

- (void)setUpPadSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(29, 95, 228, 35)];
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
    [_accountField setFont:[UIFont systemFontOfSize:15.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.userInteractionEnabled = NO;
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set sendBtn
    UIImageView *switchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 8, 18, 18)];
    [switchImgView setImage:[UIImage imageNamed:@"padDuanxintongzhi"]];
    [accountView addSubview:switchImgView];
    
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(193, 0, 35, 35)];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:sendBtn];
    
    //set passWordView
    UIView *passWordView = [[UIView alloc] initWithFrame:CGRectMake(29, 139, 228, 35)];
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
    [_passWordField setFont:[UIFont systemFontOfSize:15.0]];
    [_passWordField setTextColor:[UIColor whiteColor]];
    _passWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_passWordField setReturnKeyType:UIReturnKeyDone];
    _passWordField.userInteractionEnabled = NO;
    _passWordField.delegate = self;
    [passWordView addSubview:_passWordField];
    
    //set registBtn
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 187, 107, 35)];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [registBtn setTitle:@"注册新账号" forState:UIControlStateNormal];
    [registBtn setTitle:@"注册新账号" forState:UIControlStateHighlighted];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    
    //set changeBtn
    UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 187, 107, 35)];
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
    [changeBtn setTitle:@"切换账号" forState:UIControlStateNormal];
    [changeBtn setTitle:@"切换账号" forState:UIControlStateHighlighted];
    [changeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [changeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [changeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    //set beginBtn
    UIButton *beginBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 231, 228, 35)];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"padZhuce"] forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"padZhuce"] forState:UIControlStateHighlighted];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateNormal];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateHighlighted];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [beginBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
    
    //set messageLab
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(66, 280, 30, 35)];
    [messageLab setText:@"点击"];
    [messageLab setFont:[UIFont systemFontOfSize:15.0]];
    [messageLab setTextColor:[UIColor whiteColor]];
    [messageLab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:messageLab];
    
    //set messageImgView
    UIImageView *messageImgView = [[UIImageView alloc] initWithFrame:CGRectMake(96, 289, 18, 18)];
    [messageImgView setImage:[UIImage imageNamed:@"CXduanxintongzhi"]];
    [self.view addSubview:messageImgView];
    
    //set lastLab
    UILabel *lastLab = [[UILabel alloc] initWithFrame:CGRectMake(114, 280, 108, 35)];
    [lastLab setText:@"保存账号到手机"];
    [lastLab setFont:[UIFont systemFontOfSize:15.0]];
    [lastLab setTextColor:[UIColor whiteColor]];
    [lastLab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lastLab];
}

- (void)initAccount
{
    //获取时间戳
    NSString *timeStr = [NSString stringWithFormat:@"%.0f", [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970] * 1000];
    _username = [NSString stringWithFormat:@"%@%d", [timeStr substringWithRange:NSMakeRange(5, 4)], (arc4random() % ((9999-1000) + 1) + 1000)];
    _password = [NSString stringWithFormat:@"%@%d", [timeStr substringWithRange:NSMakeRange(5, 4)], (arc4random() % ((9999-1000) + 1) + 1000)];
    
    _accountField.text = _username;
    _passWordField.text = _password;
}

#pragma mark - resetView
- (void)resetView
{
    [_accountField resignFirstResponder];
    [_passWordField resignFirstResponder];
    
    _accountField.text = _username;
    _passWordField.text = _password;
}

#pragma mark - UIButtonClick
/**
 *  发送短信
 */
- (void)sendBtnClick
{
    NSString *bodyOfMessage = [NSString stringWithFormat:@"欢迎进入畅想游戏。您的账号%@，密码%@，请使用账号或手机号码进行登录。祝您游戏愉快。", _username, _password];
    NSArray *recipients = [[NSArray alloc] init];
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText]) {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self.rootView.controller presentViewController:controller animated:YES completion:^(void) {
            [self.rootView hiddenSDK];
        }];
    }
}

/**
 *  注册新账号
 */
- (void)registBtnClick
{
    [self.rootView showTabByTag:TYPE_REGISTER];
}

/**
 *  切换账号
 */
- (void)changeBtnClick
{
    [self.rootView showTabByTag:TYPE_LOGIN];
}

/**
 *  进入游戏
 */
- (void)beginBtnClick
{
    NSString *username = _accountField.text;
    NSString *password = _passWordField.text;
    
    if ([StringUtil isEmpty:username]) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    
    if ([StringUtil isEmpty:password]) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    }
    
    NSDictionary *dic = @{@"username": username,
                          @"password": password,
                          @"isGuset": @"1"
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
                //关闭SDK
                [self.rootView closeSDK];
                //重新生成账号
                [self initAccount];
                //TD
                [TalkingDataAppCpa onRegister:user.user_id];
            } else if (code == 17) {
                [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户已经存在,点击确定重新生成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
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
    [self.rootView showTabByTag:TYPE_LOGIN];
}

#pragma UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self initAccount];
}

#pragma mark - MFMessageComposeViewControllerDelegate methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self.rootView.controller dismissViewControllerAnimated:YES completion:nil];
    [self.rootView openSDK:self.rootView.controller];
    [self.rootView showTabByTag:TYPE_TOURISTS_LOGIN];
    switch (result) {
        case MessageComposeResultCancelled:
            [SVProgressHUD showErrorWithStatus:@"Cancelled"];
            break;
        case MessageComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:@"发送短信错误"];
            break;
        case MessageComposeResultSent:
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            break;
        default:
            break;
    }
}


@end
