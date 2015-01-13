//
//  BXSDKViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CXSDKViewController.h"
#import "LoginViewController.h"
#import "UserLoginViewController.h"
#import "RegistViewController.h"
#import "IsBindPhoneViewController.h"
#import "ChangePasswordViewController.h"
#import "TouristsViewController.h"
#import "BindPhoneViewController.h"
#import "ForgotPasswordViewController.h"
#import "ResetpasswordViewController.h"
#import "CustomIOS7AlertView.h"
#import "Common.h"
#import "CXCommon.h"
#import "DeviceInfo.h"

@interface CXSDKViewController () {
@private
    BaseViewController  *_currentVct;
    NSInteger           _selectedIndex;
    NSArray             *_actArray;
    UIView              *_bodyView;
    CustomIOS7AlertView *_alertView;
}

@end

@implementation CXSDKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self loadHeaderView];
        [self loadSubviews];
    } else {
        [self loadPadHeaderView];
        [self loadPadSubViews];
    }
}

#pragma mark - initSDK
- (void)initSDK:(UIViewController*)controller
{
    NSDictionary *dic = @{@"appID": _appID,
                          @"serviceID": _serverID,
                          };
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [USER_DEFAULT setObject:infoDic forKey:INITINFO];
    [USER_DEFAULT synchronize];
    
    NSDictionary *parDic = @{@"imei": [DeviceInfo getIDFA]};

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parDic];
    
    [GGNetWork getHttp:@"user/serverkey" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if (code == 1) {
                NSString *serviceKey = [[responseObj objectForKey:@"data"] stringValue];
                [infoDic setObject:serviceKey forKey:@"serviceKey"];
                [USER_DEFAULT setObject:infoDic forKey:INITINFO];
                [USER_DEFAULT synchronize];
                [self openSDK:controller];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

- (void)openSDK:(UIViewController *)controller
{
    self.controller = controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self loadHeaderView];
        self.view.frame = KIPHONE_ALERT_FRAME;
        _alertView = [[CustomIOS7AlertView alloc] init];
        [_alertView setContainerView:self.view];
        [_alertView setUseMotionEffects:true];
        // And launch the dialog
        [_alertView show];
    } else {
        [self loadPadHeaderView];
        self.view.frame = KIPAD_ALERT_FRAME;
        _alertView = [[CustomIOS7AlertView alloc] init];
        [_alertView setContainerView:self.view];
        [_alertView setUseMotionEffects:true];
        // And launch the dialog
        [_alertView show];
    }
}

- (void)closeSDK
{
    [_alertView close];

    NSDictionary *dic = @{@"user_id": [Common getUser].user_id ? [Common getUser].user_id : @"",
                          @"ticket": [Common getUser].ticket ? [Common getUser].ticket : @""
                          };
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCCESSED_NOTIFICATION object:nil userInfo:dic];
}

- (void)hiddenSDK
{
    [_alertView setHidden:YES];
}

- (void)showSDK
{
    [_alertView setHidden:NO];
}

#pragma mark - loadView
- (void)loadHeaderView
{
    self.view.frame = KIPHONE_ALERT_FRAME;
    self.view.backgroundColor = [UIColor clearColor];
    self.tabBarController.view.backgroundColor = [UIColor clearColor];
    
    //set logoView
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(26, 15, 177, 37)];
    [logoView setImage:[UIImage imageNamed:@"changxiangyouxi"]];
    [self.view addSubview:logoView];
    
    _bodyView = [[UIView alloc] initWithFrame:KIPHONE_ALERT_FRAME];
    [self.view addSubview:_bodyView];
    
    BaseViewController *userVct = [_actArray objectAtIndex:TYPE_USER_LOGIN];
    BaseViewController *vct = [_actArray objectAtIndex:TYPE_LOGIN];
    
    for (BaseViewController *vc in _actArray) {
        [vc.view removeFromSuperview];
    }
    
    if ([Common getUser].nick_name.length) {
        [vct.view removeFromSuperview];
        [_bodyView addSubview:userVct.view];
        _currentVct = userVct;
    } else {
        [userVct.view removeFromSuperview];
        [_bodyView addSubview:vct.view];
        _currentVct = vct;
    }
    [_currentVct resetView];
}

- (void)loadPadHeaderView
{
    self.view.frame = KIPAD_ALERT_FRAME;
    self.view.backgroundColor = [UIColor clearColor];
    self.tabBarController.view.backgroundColor = [UIColor clearColor];
    
    //set logoView
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(26, 15, 228, 48)];
    [logoView setImage:[UIImage imageNamed:@"padChangxiangyouxi"]];
    [self.view addSubview:logoView];
    
    _bodyView = [[UIView alloc] initWithFrame:KIPAD_ALERT_FRAME];
    [self.view addSubview:_bodyView];
    
    BaseViewController *userVct = [_actArray objectAtIndex:TYPE_USER_LOGIN];
    BaseViewController *vct = [_actArray objectAtIndex:TYPE_LOGIN];
    
    for (BaseViewController *vc in _actArray) {
        [vc.view removeFromSuperview];
    }
    if ([Common getUser].nick_name.length) {
        [vct.view removeFromSuperview];
        [_bodyView addSubview:userVct.view];
        _currentVct = userVct;
    } else {
        [userVct.view removeFromSuperview];
        [_bodyView addSubview:vct.view];
        _currentVct = vct;
    }
    
    [_currentVct resetView];
}

- (void)loadSubviews
{
    LoginViewController *loginVct = [[LoginViewController alloc] init];
    loginVct.view.frame = KIPHONE_ALERT_FRAME;
    loginVct.rootView = self;
    
    UserLoginViewController *userVct = [[UserLoginViewController alloc] init];
    userVct.view.frame = KIPHONE_ALERT_FRAME;
    userVct.rootView = self;
    
    RegistViewController *registerVct = [[RegistViewController alloc] init];
    registerVct.view.frame = KIPHONE_ALERT_FRAME;
    registerVct.rootView = self;
    
    IsBindPhoneViewController *ibpVct = [[IsBindPhoneViewController alloc] init];
    ibpVct.view.frame = KIPHONE_ALERT_FRAME;
    ibpVct.rootView = self;
    
    ChangePasswordViewController *cpVct = [[ChangePasswordViewController alloc] init];
    cpVct.view.frame = KIPHONE_ALERT_FRAME;
    cpVct.rootView = self;
    
    TouristsViewController *tlVct = [[TouristsViewController alloc] init];
    tlVct.view.frame = KIPHONE_ALERT_FRAME;
    tlVct.rootView = self;
    
    BindPhoneViewController *bpVct = [[BindPhoneViewController alloc] init];
    bpVct.view.frame = KIPHONE_ALERT_FRAME;
    bpVct.rootView = self;
    
    ForgotPasswordViewController *fpVct = [[ForgotPasswordViewController alloc] init];
    fpVct.view.frame = KIPHONE_ALERT_FRAME;
    fpVct.rootView = self;
    
    ResetpasswordViewController *rsVct = [[ResetpasswordViewController alloc] init];
    rsVct.view.frame = KIPHONE_ALERT_FRAME;
    rsVct.rootView = self;
    
    _actArray = @[loginVct, userVct, registerVct, ibpVct, cpVct, tlVct, bpVct, fpVct, rsVct];
    
    [_bodyView addSubview:loginVct.view];
    _currentVct = loginVct;
    _selectedIndex = TYPE_LOGIN;
}

- (void)loadPadSubViews
{
    LoginViewController *loginVct = [[LoginViewController alloc] init];
    loginVct.view.frame = KIPAD_ALERT_FRAME;
    loginVct.rootView = self;
    
    UserLoginViewController *userVct = [[UserLoginViewController alloc] init];
    userVct.view.frame = KIPAD_ALERT_FRAME;
    userVct.rootView = self;
    
    RegistViewController *registerVct = [[RegistViewController alloc] init];
    registerVct.view.frame = KIPAD_ALERT_FRAME;
    registerVct.rootView = self;
    
    IsBindPhoneViewController *ibpVct = [[IsBindPhoneViewController alloc] init];
    ibpVct.view.frame = KIPAD_ALERT_FRAME;
    ibpVct.rootView = self;

    ChangePasswordViewController *cpVct = [[ChangePasswordViewController alloc] init];
    cpVct.view.frame = KIPAD_ALERT_FRAME;
    cpVct.rootView = self;
    
    TouristsViewController *tlVct = [[TouristsViewController alloc] init];
    tlVct.view.frame = KIPAD_ALERT_FRAME;
    tlVct.rootView = self;
    
    BindPhoneViewController *bpVct = [[BindPhoneViewController alloc] init];
    bpVct.view.frame = KIPAD_ALERT_FRAME;
    bpVct.rootView = self;
    
    ForgotPasswordViewController *fpVct = [[ForgotPasswordViewController alloc] init];
    fpVct.view.frame = KIPAD_ALERT_FRAME;
    fpVct.rootView = self;
    
    ResetpasswordViewController *rsVct = [[ResetpasswordViewController alloc] init];
    rsVct.view.frame = KIPAD_ALERT_FRAME;
    rsVct.rootView = self;
    
    _actArray = @[loginVct, userVct, registerVct, ibpVct, cpVct, tlVct, bpVct, fpVct, rsVct];
    
    [_bodyView addSubview:loginVct.view];
    _currentVct = loginVct;
    _selectedIndex = TYPE_LOGIN;
}

#pragma mark - showView
- (void)showTabByTag:(NSInteger)tag
{
    [self showTabView:tag];
}

- (void)showTabView:(NSInteger)tag
{
    BaseViewController *vct = [_actArray objectAtIndex:tag];
    [vct resetView];
    [_bodyView addSubview:vct.view];
    [_currentVct.view removeFromSuperview];
    [_currentVct resetView];
    _currentVct = vct;
    NSLog(@"%@", _currentVct);
}


#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
