//
//  MainViewController.m
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MainViewController.h"
#import "CXComPlatformBase.h"
#import "CXInitConfigure.h"
#import "SVProgressHUD.h"
#import "CXPayParams.h"
#import "BPPurchaseHelper.h"

@interface MainViewController () 

@end

@implementation MainViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - interfaceOrientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark - Action
#pragma mark - 初始化SDK
- (void)startSDK
{
    CXInitConfigure *cfg = [[CXInitConfigure alloc] init];
    cfg.appId = @"10004";
    cfg.cpKey = @"123456";
    cfg.serverId = @"2";
    cfg.controller = self;
    [[CXComPlatformBase defaultPlatform] CXInit:cfg];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lgoinSuccessedCallBack:) name:LOGIN_SUCCESSED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailedCallBack:) name:LOGIN_FAILED_NOTIFICATION object:nil];
}

#pragma mark - 登录回调
- (void)lgoinSuccessedCallBack:(NSNotification *)notification
{
    NSString *userID = [notification.userInfo objectForKey:@"user_id"];
    NSString *ticket = [notification.userInfo objectForKey:@"ticket"];
    NSString *result = [NSString stringWithFormat:@"登录成功 userID=%@, ticket=%@", userID, ticket];
    [SVProgressHUD showSuccessWithStatus:result];
    NSLog(@"%@",result);
}

- (void)loginFailedCallBack:(NSNotification *)notification
{
    NSString *resultCode = [notification.userInfo objectForKey:@"code"];
    NSString *result = [NSString stringWithFormat:@"登录失败 resultCode=%@", resultCode];
    [SVProgressHUD showErrorWithStatus:result];
    NSLog(@"%@",result);
}

#pragma mark - 开始支付
- (void)startPay
{
    CXPayParams *params = [[CXPayParams alloc] init];
    params.amount = @"0.01";
    params.productName = @"商品名称";
    params.productDescription = @"商品描述";
    params.cp_bill_no = @"123456";
    params.notify_url = @"http://pay.zjszz.173.com/pay!finishOrder.action?aaa=bbb&ccc=ddd";
    params.extra = @"abc2013-05-24";
    params.controller = self;
    [[BPPurchaseHelper sharedHelper] setCXPayParams:params];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseSuccessedCallBack:) name:PURCHASE_SUCCESSED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseFailedCallBack:) name:PURCHASE_FAILED_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseCancelledCallBack:) name:PURCHASE_CANCELLED_NOTIFICATION object:nil];
}

#pragma mark - 支付回调
- (void)purchaseSuccessedCallBack:(NSNotification *)notification
{
    NSString *productName = [notification.userInfo objectForKey:@"productName"];
    NSString *resultStatus = [notification.userInfo objectForKey:@"resultStatus"];
    NSString *payType = [notification.userInfo objectForKey:@"payType"];
    NSString *result = [NSString stringWithFormat:@"%@ %@ 支付成功 resultCode=%@", payType, productName, resultStatus];
    [SVProgressHUD showErrorWithStatus:result];
}

- (void)purchaseFailedCallBack:(NSNotification *)notification
{
    NSString *productName = [notification.userInfo objectForKey:@"productName"];
    NSString *resultStatus = [notification.userInfo objectForKey:@"resultStatus"];
    NSString *payType = [notification.userInfo objectForKey:@"payType"];
    NSString *result = [NSString stringWithFormat:@"%@ %@ 支付失败 resultCode=%@", payType, productName, resultStatus];
    [SVProgressHUD showErrorWithStatus:result];
}

- (void)purchaseCancelledCallBack:(NSNotification *)notification
{
    NSString *productName = [notification.userInfo objectForKey:@"productName"];
    NSString *resultStatus = [notification.userInfo objectForKey:@"resultStatus"];
    NSString *payType = [notification.userInfo objectForKey:@"payType"];
    NSString *result = [NSString stringWithFormat:@"%@ %@ 用户取消 resultCode=%@", payType, productName, resultStatus];
    [SVProgressHUD showErrorWithStatus:result];
}

@end
