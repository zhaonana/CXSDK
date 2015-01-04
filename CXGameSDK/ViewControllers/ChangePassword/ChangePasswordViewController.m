//
//  ChangePasswordViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "StringUtil.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "GGNetWork.h"

@interface ChangePasswordViewController () {
    UITextField *_oldField;
    UITextField *_newField;
    UITextField *_surePassWordField;
}

@end

@implementation ChangePasswordViewController

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
    //set oldPassWordView
    UIView *oldView = [[UIView alloc] initWithFrame:CGRectMake(26, 88, 177, 27)];
    [oldView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:oldView];
    
    //set oldPassWordBackgroundView
    UIImageView *oldBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [oldBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [oldView addSubview:oldBackView];
    
    //set oldPassWordImgView
    UIImageView *oldImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [oldImgView setImage:[UIImage imageNamed:@"CXmima"]];
    [oldView addSubview:oldImgView];
    
    //set oldPassWordTextField
    _oldField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 130, 14)];
    [_oldField setPlaceholder:@"请输入当前密码"];
    [_oldField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_oldField setFont:[UIFont systemFontOfSize:13.0]];
    [_oldField setTextColor:[UIColor whiteColor]];
    _oldField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_oldField setReturnKeyType:UIReturnKeyDone];
    _oldField.delegate = self;
    [oldView addSubview:_oldField];
    
    //set newPassWordView
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(26, 122, 177, 27)];
    [newView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:newView];
    
    //set newPassWordBackgroundView
    UIImageView *newBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 177, 27)];
    [newBackView setImage:[UIImage imageNamed:@"CXshoujichangtouming"]];
    [newView addSubview:newBackView];
    
    //set newPassWordImgView
    UIImageView *newImgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 15, 15)];
    [newImgView setImage:[UIImage imageNamed:@"CXmima"]];
    [newView addSubview:newImgView];
    
    //set newPassWordTextField
    _newField = [[UITextField alloc] initWithFrame:CGRectMake(35, 7, 130, 14)];
    [_newField setPlaceholder:@"请输入修改后的密码"];
    [_newField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_newField setFont:[UIFont systemFontOfSize:13.0]];
    [_newField setTextColor:[UIColor whiteColor]];
    _newField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_newField setReturnKeyType:UIReturnKeyDone];
    _newField.delegate = self;
    [newView addSubview:_newField];
    
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
    [_surePassWordField setPlaceholder:@"请确认密码"];
    [_surePassWordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_surePassWordField setFont:[UIFont systemFontOfSize:13.0]];
    [_surePassWordField setTextColor:[UIColor whiteColor]];
    _surePassWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_surePassWordField setReturnKeyType:UIReturnKeyDone];
    _surePassWordField.delegate = self;
    [surePassWordView addSubview:_surePassWordField];
    
    //set submitBtn
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 193, 84, 27)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateHighlighted];
    [submitBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [submitBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
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
    //set oldPassWordView
    UIView *oldView = [[UIView alloc] initWithFrame:CGRectMake(29, 105, 228, 35)];
    [oldView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:oldView];
    
    //set oldPassWordBackgroundView
    UIImageView *oldBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [oldBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [oldView addSubview:oldBackView];
    
    //set oldPassWordImgView
    UIImageView *oldImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [oldImgView setImage:[UIImage imageNamed:@"padMima"]];
    [oldView addSubview:oldImgView];
    
    //set oldPassWordTextField
    _oldField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 180, 15)];
    [_oldField setPlaceholder:@"请输入当前密码"];
    [_oldField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_oldField setFont:[UIFont systemFontOfSize:15.0]];
    [_oldField setTextColor:[UIColor whiteColor]];
    _oldField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_oldField setReturnKeyType:UIReturnKeyDone];
    _oldField.delegate = self;
    [oldView addSubview:_oldField];
    
    //set newPassWordView
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(29, 149, 228, 35)];
    [newView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:newView];
    
    //set newPassWordBackgroundView
    UIImageView *newBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 228, 35)];
    [newBackView setImage:[UIImage imageNamed:@"padChangtouming"]];
    [newView addSubview:newBackView];
    
    //set newPassWordImgView
    UIImageView *newImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 18, 18)];
    [newImgView setImage:[UIImage imageNamed:@"padMima"]];
    [newView addSubview:newImgView];
    
    //set newPassWordTextField
    _newField = [[UITextField alloc] initWithFrame:CGRectMake(43, 10, 180, 15)];
    [_newField setPlaceholder:@"请输入修改后的密码"];
    [_newField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_newField setFont:[UIFont systemFontOfSize:15.0]];
    [_newField setTextColor:[UIColor whiteColor]];
    _newField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_newField setReturnKeyType:UIReturnKeyDone];
    _newField.delegate = self;
    [newView addSubview:_newField];
    
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
    [_surePassWordField setPlaceholder:@"请确认密码"];
    [_surePassWordField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_surePassWordField setFont:[UIFont systemFontOfSize:15.0]];
    [_surePassWordField setTextColor:[UIColor whiteColor]];
    _surePassWordField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_surePassWordField setReturnKeyType:UIReturnKeyDone];
    _surePassWordField.delegate = self;
    [surePassWordView addSubview:_surePassWordField];
    
    //set submitBtn
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 237, 107, 35)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateHighlighted];
    [submitBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [submitBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
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

/**
 *  设置键盘消失
 */
- (void)setKeyBoardHidden
{
    [_oldField resignFirstResponder];
    [_newField resignFirstResponder];
    [_surePassWordField resignFirstResponder];
}

#pragma mark - UIButtonClick
/**
 *  提交
 */
- (void)submitBtnClick
{
    [self setKeyBoardHidden];
    
    NSString *oldPassword = _oldField.text;
    NSString *newPassword = _newField.text;
    NSString *surePassword = _surePassWordField.text;
    
    if ([StringUtil isEmpty:oldPassword]) {
        [SVProgressHUD showErrorWithStatus:@"旧密码不能为空"];
        return;
    }
    if (![oldPassword isEqualToString:[Common getUser].password]) {
        [SVProgressHUD showErrorWithStatus:@"旧密码不正确"];
        return;
    }
    if ([StringUtil isEmpty:newPassword]) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空"];
        return;
    }
    if (![newPassword isEqualToString:surePassword]) {
        [SVProgressHUD showErrorWithStatus:@"确认密码不正确"];
        return;
    }
    if (newPassword.length < 6 || newPassword.length > 20) {
        [SVProgressHUD showErrorWithStatus:@"密码必须为6-20个英文字母或数字"];
        return;
    }
    
    NSDictionary *dic = @{@"user_id": [Common getUser].user_id,
                          @"original_pwd": oldPassword,
                          @"new_pwd": newPassword
                          };

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"user/changepwd" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                UserModel *user = [Common getUser];
                user.password = newPassword;
                [self saveUsers:user];
                [Common setUser:user];
                [self performSelector:@selector(backBtnClick) withObject:self afterDelay:0.3];
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
    [self.rootView showTabByTag:TYPE_USER_LOGIN];
}

#pragma mark - resetView
- (void)resetView
{
    _oldField.text = @"";
    _newField.text = @"";
    _surePassWordField.text = @"";
    
    [self setKeyBoardHidden];
}

@end
