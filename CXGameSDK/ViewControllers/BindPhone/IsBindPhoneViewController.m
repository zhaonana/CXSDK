//
//  IsBindPhoneViewController.m
//  CXGameSDK
//
//  Created by NaNa on 14-10-24.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "IsBindPhoneViewController.h"

@interface IsBindPhoneViewController ()

@end

@implementation IsBindPhoneViewController

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
    //set accountLab
    UILabel *accountLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 72, 122, 27)];
    [accountLab setText:@"您的账号安全级别:低"];
    [accountLab setTextColor:[UIColor whiteColor]];
    [accountLab setFont:[UIFont systemFontOfSize:13.0]];
    [accountLab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:accountLab];
    
    //set accountImgView
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(144, 84, 66, 5)];
    [accountImgView setImage:[UIImage imageNamed:@"bx_icon_safety_line"]];
    [self.view addSubview:accountImgView];
    
    //set alertLab
    UILabel *alertlab = [[UILabel alloc] initWithFrame:CGRectMake(22, 100, 190, 54)];
    [alertlab setText:@"绑定手机可以找回密码也可以用手机号登陆"];
    [alertlab setNumberOfLines:0];
    [alertlab setTextColor:[UIColor whiteColor]];
    [alertlab setFont:[UIFont systemFontOfSize:13.0]];
    [alertlab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:alertlab];
    
    //set bindBtn
    UIButton *bindBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 163, 177, 27)];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateNormal];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"CXyoukedenglu"] forState:UIControlStateHighlighted];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateHighlighted];
    [bindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [bindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [bindBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [bindBtn addTarget:self action:@selector(bindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindBtn];
    
    //set notBindBtn
    UIButton *notBindBtn = [[UIButton alloc] initWithFrame:CGRectMake(26, 200, 177, 27)];
    [notBindBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateNormal];
    [notBindBtn setBackgroundImage:[UIImage imageNamed:@"CXdengluyouxi"] forState:UIControlStateHighlighted];
    [notBindBtn setTitle:@"以后绑定" forState:UIControlStateNormal];
    [notBindBtn setTitle:@"以后绑定" forState:UIControlStateHighlighted];
    [notBindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [notBindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [notBindBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [notBindBtn addTarget:self action:@selector(notBindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notBindBtn];
}

- (void)setUpPadSubViews
{
    //set accountLab
    UILabel *accountLab = [[UILabel alloc] initWithFrame:CGRectMake(28, 102, 152, 27)];
    [accountLab setText:@"您的账号安全级别:低"];
    [accountLab setTextColor:[UIColor whiteColor]];
    [accountLab setFont:[UIFont systemFontOfSize:15.0]];
    [accountLab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:accountLab];
    
    //set accountImgView
    UIImageView *accountImgView = [[UIImageView alloc] initWithFrame:CGRectMake(178, 114, 66, 5)];
    [accountImgView setImage:[UIImage imageNamed:@"bx_icon_safety_line"]];
    [self.view addSubview:accountImgView];
    
    //set alertLab
    UILabel *alertlab = [[UILabel alloc] initWithFrame:CGRectMake(27, 126, 230, 70)];
    [alertlab setText:@"绑定手机可以找回密码也可以用手机号登陆"];
    [alertlab setNumberOfLines:0];
    [alertlab setTextColor:[UIColor whiteColor]];
    [alertlab setFont:[UIFont systemFontOfSize:15.0]];
    [alertlab setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:alertlab];
    
    //set bindBtn
    UIButton *bindBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 202, 228, 35)];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateNormal];
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"padYouikedenglu"] forState:UIControlStateHighlighted];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
    [bindBtn setTitle:@"立即绑定" forState:UIControlStateHighlighted];
    [bindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [bindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [bindBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [bindBtn addTarget:self action:@selector(bindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bindBtn];
    
    //set notBindBtn
    UIButton *notBindBtn = [[UIButton alloc] initWithFrame:CGRectMake(29, 250, 228, 35)];
    [notBindBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateNormal];
    [notBindBtn setBackgroundImage:[UIImage imageNamed:@"padDengluyouxi"] forState:UIControlStateHighlighted];
    [notBindBtn setTitle:@"以后绑定" forState:UIControlStateNormal];
    [notBindBtn setTitle:@"以后绑定" forState:UIControlStateHighlighted];
    [notBindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [notBindBtn setTitleColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:66.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [notBindBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [notBindBtn addTarget:self action:@selector(notBindBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notBindBtn];
}

#pragma mark - UIButtonClick
/**
 *  立即绑定
 */
- (void)bindBtnClick
{
    [self.rootView showTabByTag:TYPE_BIND_PHONE];
}

/**
 *  以后绑定
 */
- (void)notBindBtnClick
{
    [self.rootView closeSDK];
}

@end
