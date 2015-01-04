//
//  UserLoginViewController.m
//  CXGameSDK
//
//  Created by NaNa on 14-10-16.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "UserLoginViewController.h"
#import "PreferencesUtils.h"
#import "TalkingDataAppCpa.h"

@interface UserLoginViewController () {
    UITextField    *_accountField;
    NSMutableArray *_userArray;
    UIButton       *_bindPhoneBtn;
    UIButton       *_changeBtn;
}

@end

@implementation UserLoginViewController

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
    
    [Common setBindPhone:NO];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self setUpSubViews];
    } else {
        [self setUpPadSubViews];
    }
//    [self initSaveUser];
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
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(26, 102, 177, 27)];
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
    
    //set switchBtn
    UIImageView *switchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(156, 6, 15, 15)];
    [switchImgView setImage:[UIImage imageNamed:@"CXqiehuanzhanghao"]];
    [accountView addSubview:switchImgView];
    
    UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(150, 0, 27, 27)];
    [switchBtn addTarget:self action:@selector(switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:switchBtn];
    
    //set accountTextField
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 118, 14)];
    [_accountField setFont:[UIFont systemFontOfSize:13.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.userInteractionEnabled = NO;
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set bindPhoneBtn
    _bindPhoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 140, 84, 27)];
    [_bindPhoneBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [_bindPhoneBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [_bindPhoneBtn setTitle:@"绑定手机" forState:UIControlStateNormal];
    [_bindPhoneBtn setTitle:@"绑定手机" forState:UIControlStateHighlighted];
    [_bindPhoneBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [_bindPhoneBtn addTarget:self action:@selector(bindPhoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bindPhoneBtn];
    
    //set changePassWordBtn
    _changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(119, 140, 84, 27)];
    [_changeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
    [_changeBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
    [_changeBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [_changeBtn setTitle:@"修改密码" forState:UIControlStateHighlighted];
    [_changeBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [_changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeBtn];
    
    //set bindPhoneBtn and changePassWordBtn state
    [self setUpBtnState];
    
    //set beginBtn
    UIButton *beginBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 173, 177, 27)];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"CXzhuce"] forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"CXzhuce"] forState:UIControlStateHighlighted];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateNormal];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateHighlighted];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [beginBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
}

- (void)setUpPadSubViews
{
    //set accountView
    UIView *accountView = [[UIView alloc] initWithFrame:CGRectMake(29, 122, 228, 35)];
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
    
    //set switchBtn
    UIImageView *switchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 8, 18, 18)];
    [switchImgView setImage:[UIImage imageNamed:@"padQiehuanzhanghao"]];
    [accountView addSubview:switchImgView];
    
    UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(193, 0, 35, 35)];
    [switchBtn addTarget:self action:@selector(switchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [accountView addSubview:switchBtn];
    
    //set accountTextField
    _accountField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 150, 15)];
    [_accountField setFont:[UIFont systemFontOfSize:15.0]];
    [_accountField setTextColor:[UIColor whiteColor]];
    _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_accountField setReturnKeyType:UIReturnKeyDone];
    _accountField.userInteractionEnabled = NO;
    _accountField.delegate = self;
    [accountView addSubview:_accountField];
    
    //set bindPhoneBtn
    _bindPhoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 170, 107, 35)];
    [_bindPhoneBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [_bindPhoneBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [_bindPhoneBtn setTitle:@"绑定手机" forState:UIControlStateNormal];
    [_bindPhoneBtn setTitle:@"绑定手机" forState:UIControlStateHighlighted];
    [_bindPhoneBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [_bindPhoneBtn addTarget:self action:@selector(bindPhoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bindPhoneBtn];
    
    //set changePassWordBtn
    _changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(149, 170, 107, 35)];
    [_changeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
    [_changeBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
    [_changeBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [_changeBtn setTitle:@"修改密码" forState:UIControlStateHighlighted];
    [_changeBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [_changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeBtn];
    
    //set _bindPhoneBtn and changePassWordBtn state
    [self setUpBtnState];
    
    //set beginBtn
    UIButton *beginBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 214, 228, 35)];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"padZhuce"] forState:UIControlStateNormal];
    [beginBtn setBackgroundImage:[UIImage imageNamed:@"padZhuce"] forState:UIControlStateHighlighted];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateNormal];
    [beginBtn setTitle:@"进入游戏" forState:UIControlStateHighlighted];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [beginBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [beginBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [beginBtn addTarget:self action:@selector(beginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:beginBtn];
}

- (void)setUpBtnState
{
    if ([[Common getUser].origin integerValue] == 1 || [[Common getUser].origin integerValue] == 2) {
        [_bindPhoneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_bindPhoneBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _bindPhoneBtn.userInteractionEnabled = NO;
        [_changeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _changeBtn.userInteractionEnabled = NO;
        _accountField.textColor = [UIColor colorWithRed:90.0/255.0 green:167.0/255.0 blue:225.0/255.0 alpha:1.0];
    } else {
        [_bindPhoneBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_bindPhoneBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        _bindPhoneBtn.userInteractionEnabled = YES;
        [_changeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
        _changeBtn.userInteractionEnabled = YES;
        _accountField.textColor = [UIColor whiteColor];
    }
}

#pragma mark - UIButtonClick
/**
 *  绑定手机
 */
- (void)bindPhoneBtnClick
{
    if ([Common isBindPhone]) {
        [SVProgressHUD showErrorWithStatus:@"该账号已绑定手机号"];
    } else {
        [self.rootView showTabByTag:TYPE_BIND_PHONE];
    }
}

/**
 *  修改密码
 */
- (void)changeBtnClick
{
    [self.rootView showTabByTag:TYPE_CHANGE_PASSWROD];
}

/**
 *  进入游戏
 */
- (void)beginBtnClick
{
    NSString *username = [Common getUser].username;
    NSString *password = [Common getUser].password;
    NSString *origin = [Common getUser].origin;
    NSString *userid = [Common getUser].user_id;
    
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
                //发送回调
                NSDictionary *dic = [responseObj objectForKey:@"data"];
                UserModel *user = [JsonUtil parseUserModel:dic];
                user.username = username;
                user.password = password;
                user.origin = origin;

                //保存账户密码
                [self saveUsers:user];
                //设置当前用户信息
                [Common setUser:user];
                
                if ([[Common getUser].origin integerValue] == 3 && ![Common isBindPhone]) {
                    [self.rootView showTabByTag:TYPE_ISBIND_PHONE];
                } else {
                    [self.rootView closeSDK];
                }
                
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
 *  切换账户
 */
- (void)switchBtnClick
{
    [self.rootView showTabByTag:TYPE_LOGIN];
}

#pragma mark - resetView
- (void)resetView
{
    [self initSaveUser];
    
    if ([Common getUser]) {
        _accountField.text = [Common getUser].nick_name;
    }
    
    //set _bindPhoneBtn and changePassWordBtn state
    [self setUpBtnState];
}

/*
 * 初始化保存的账户
 */
- (void)initSaveUser
{
    BOOL isUser = NO;
    NSString *json = [PreferencesUtils getStringForKey:kUserNames];
    if([StringUtil isNotEmpty:json]){
        NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
        _userArray = [JsonUtil parseUserModelArrayStr:[self parseJsonData:data]];
        if(_userArray && [_userArray count] > 0){
            [Common setUser:[_userArray objectAtIndex:_userArray.count - 1]];
            _accountField.text = [Common getUser].nick_name;
            if (![Common isBindPhone]) {
                NSLog(@"用户填写手机号码，与当前账号进行绑定，用于密码找回~");
                [self isBindPhone];
            } else {
                NSLog(@"该账号已绑定手机号~");
            }
            isUser = YES;
        }
    }
}

- (void)isBindPhone
{
    NSDictionary *dic = @{@"user_id": [Common getUser].user_id};
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"user/isbindmobile" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if(code == 1){
                //发送回调
                NSLog(@"该账号已绑定手机号~");
                [Common setBindPhone:YES];
            } else {
                NSLog(@"用户填写手机号码，与当前账号进行绑定，用于密码找回~");
                [Common setBindPhone:NO];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

@end
