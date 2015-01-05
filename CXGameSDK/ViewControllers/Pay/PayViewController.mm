//
//  PayViewController.m
//  CXGameSDK
//
//  Created by NaNa on 14/12/29.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "PayViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "UPPayPlugin.h"
#import "TalkingDataAppCpa.h"
#import "CXCommon.h"

#define kUPPayMode @"00"
//支付成功通知
#define PURCHASE_SUCCESSED_NOTIFICATION @"purchaseSucessedNotification"
//支付失败通知
#define PURCHASE_FAILED_NOTIFICATION @"purchaseFailedNotification"
//支付取消通知
#define PURCHASE_CANCELLED_NOTIFICATION @"purchasecancelledNotification"
//支付宝回调通知
#define PURCHASE_PAYMENTRESULT_NOTIFICATION @"purchasePaymentResultNotification"

@interface PayViewController () <UPPayPluginDelegate>

@property (nonatomic, strong) UILabel  *sureLabel;
@property (nonatomic, strong) UIButton *alipayButton;
@property (nonatomic, strong) UIButton *uppayButton;

@end

@implementation PayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self setUpView];
    } else {
        [self setUpPadView];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchasePaymentResult:) name:PURCHASE_PAYMENTRESULT_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setUpView
{
    // no transforms applied to window in iOS 8, but only if compiled with iOS 8 sdk as base sdk, otherwise system supports old rotation logic.
    BOOL ignoreOrientation = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[NSProcessInfo processInfo] respondsToSelector:@selector(operatingSystemVersion)]) {
        ignoreOrientation = YES;
    }
#endif
    
    float screenHeight = 0;
    float screenWidth = 0;
    if (ignoreOrientation) {
        screenHeight = KSCREENWIDTH;
        screenWidth = KSCREENHEIGHT;
    } else {
        screenHeight = KSCREENHEIGHT;
        screenWidth = KSCREENWIDTH;
    }

    //set navigationView
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, screenWidth, 39)];
    [navigationView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:navigationView];
    
    //set backButton
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(12, 6, 42, 24)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateHighlighted];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [backButton setTag:100];
    [backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backButton];
    
    //set titleLabel
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWidth - 74)/2, 8, 74, 21)];
    [titleLabel setText:@"充值中心"];
    [titleLabel setFont:[UIFont systemFontOfSize:18.0]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [navigationView addSubview:titleLabel];
    
    //set leftBarView
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 59, 75, screenHeight - 59)];
    [leftImgView setImage:[UIImage imageNamed:@"bx_left_bar_bg"]];
    [self.view addSubview:leftImgView];
    
    //set alipayButton
    _alipayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 59, 75, 33)];
    [_alipayButton setTitle:@"支付宝" forState:UIControlStateNormal];
    [_alipayButton setTitle:@"支付宝" forState:UIControlStateSelected];
    _alipayButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_alipayButton setBackgroundImage:[UIImage imageNamed:@"bx_right_btn_default"] forState:UIControlStateNormal];
    [_alipayButton setBackgroundImage:[UIImage imageNamed:@"bx_right_btn_pressed"] forState:UIControlStateSelected];
    [_alipayButton setSelected:YES];
    [_alipayButton setTag:101];
    [_alipayButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_alipayButton];
    
    //set uppayButton
    _uppayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 93, 75, 33)];
    [_uppayButton setTitle:@"银联" forState:UIControlStateNormal];
    [_uppayButton setTitle:@"银联" forState:UIControlStateSelected];
    _uppayButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_uppayButton setBackgroundImage:[UIImage imageNamed:@"bx_right_btn_default"] forState:UIControlStateNormal];
    [_uppayButton setBackgroundImage:[UIImage imageNamed:@"bx_right_btn_pressed"] forState:UIControlStateSelected];
    [_uppayButton setTag:102];
    [_uppayButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_uppayButton];
    
    //set contentView
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(76, 59, screenWidth - 76, 59)];
    [contentView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:253.0/255.0 blue:204.0/255.0 alpha:1.0]];
    [self.view addSubview:contentView];
    
    //set amountLabel
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 6, 228, 21)];
    [amountLabel setText:[NSString stringWithFormat:@"支付金额：%@",self.cxParams.amount]];
    [amountLabel setFont:[UIFont systemFontOfSize:13.0]];
    [contentView addSubview:amountLabel];
    
    //set productLabel
    UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 32, 102, 21)];
    [productLabel setText:[NSString stringWithFormat:@"商品：%@",self.cxParams.productName]];
    [productLabel setFont:[UIFont systemFontOfSize:13.0]];
    [contentView addSubview:productLabel];
    
    //set userLabel
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(119, 32, 117, 21)];
    [userLabel setText:[NSString stringWithFormat:@"用户名：%@",[Common getUser].username]];
    [userLabel setFont:[UIFont systemFontOfSize:13.0]];
    [contentView addSubview:userLabel];
    
    //set sureLabel
    _sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(92, 131, 212, 21)];
    [_sureLabel setText:@"确认无误后支付宝付款"];
    [_sureLabel setFont:[UIFont systemFontOfSize:13.0]];
    [self.view addSubview:_sureLabel];
    
    //set sureButton
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth - 275)/2 + 75, 166, 200, 30)];
    [sureButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [sureButton setTitle:@"立即支付" forState:UIControlStateSelected];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"pay"] forState:UIControlStateNormal];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"pay_click"] forState:UIControlStateSelected];
    [sureButton setTag:103];
    [sureButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
}

- (void)setUpPadView
{
    //set navigationView
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 768, 70)];
    [navigationView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:navigationView];
    
    //set backButton
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(28, 13, 101, 43)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateHighlighted];
    backButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [backButton setTag:100];
    [backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:backButton];
    
    //set titleLabel
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(295, 13, 178, 38)];
    [titleLabel setText:@"充值中心"];
    [titleLabel setFont:[UIFont systemFontOfSize:30.0]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [navigationView addSubview:titleLabel];
    
    //set leftBarView
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 180, 934)];
    [leftImgView setImage:[UIImage imageNamed:@"bx_left_bar_bg"]];
    [self.view addSubview:leftImgView];
    
    //set alipayButton
    _alipayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 90, 180, 59)];
    [_alipayButton setTitle:@"支付宝" forState:UIControlStateNormal];
    [_alipayButton setTitle:@"支付宝" forState:UIControlStateSelected];
    _alipayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [_alipayButton setBackgroundImage:[UIImage imageNamed:@"bx_right_btn_default"] forState:UIControlStateNormal];
    [_alipayButton setBackgroundImage:[UIImage imageNamed:@"bx_right_btn_pressed"] forState:UIControlStateSelected];
    [_alipayButton setSelected:YES];
    [_alipayButton setTag:101];
    [_alipayButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_alipayButton];
    
    //set uppayButton
    _uppayButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, 180, 59)];
    [_uppayButton setTitle:@"银联" forState:UIControlStateNormal];
    [_uppayButton setTitle:@"银联" forState:UIControlStateSelected];
    _uppayButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [_uppayButton setBackgroundImage:[UIImage imageNamed:@"bx_right_btn_default"] forState:UIControlStateNormal];
    [_uppayButton setBackgroundImage:[UIImage imageNamed:@"bx_right_btn_pressed"] forState:UIControlStateSelected];
    [_uppayButton setTag:102];
    [_uppayButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_uppayButton];
    
    //set contentView
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(180, 90, 586, 106)];
    [contentView setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:253.0/255.0 blue:204.0/255.0 alpha:1.0]];
    [self.view addSubview:contentView];
    
    //set amountLabel
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 12, 547, 38)];
    [amountLabel setText:[NSString stringWithFormat:@"支付金额：%@",self.cxParams.amount]];
    [amountLabel setFont:[UIFont systemFontOfSize:20.0]];
    [contentView addSubview:amountLabel];
    
    //set productLabel
    UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, 245, 38)];
    [productLabel setText:[NSString stringWithFormat:@"商品：%@",self.cxParams.productName]];
    [productLabel setFont:[UIFont systemFontOfSize:20.0]];
    [contentView addSubview:productLabel];
    
    //set userLabel
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 54, 281, 38)];
    [userLabel setText:[NSString stringWithFormat:@"用户名：%@",[Common getUser].username]];
    [userLabel setFont:[UIFont systemFontOfSize:20.0]];
    [contentView addSubview:userLabel];
    
    //set sureLabel
    _sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(228, 226, 509, 38)];
    [_sureLabel setText:@"确认无误后支付宝付款"];
    [_sureLabel setFont:[UIFont systemFontOfSize:20.0]];
    [self.view addSubview:_sureLabel];
    
    //set sureButton
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(234, 290, 480, 54)];
    [sureButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [sureButton setTitle:@"立即支付" forState:UIControlStateSelected];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"pay"] forState:UIControlStateNormal];
    [sureButton setBackgroundImage:[UIImage imageNamed:@"pay_click"] forState:UIControlStateSelected];
    [sureButton setTag:103];
    [sureButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
}

#pragma mark - UIButtonClick
- (void)buttonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100: { //返回
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
            break;
        case 101: { //支付宝
            [sender setSelected:YES];
            [_uppayButton setSelected:NO];
            [_sureLabel setText:@"确认无误后支付宝付款"];
        }
            break;
        case 102: { //银联
            [sender setSelected:YES];
            [_alipayButton setSelected:NO];
            [_sureLabel setText:@"确认无误后银联付款"];
        }
            break;
        case 103: { //立即支付
            if (_uppayButton.selected) {
                [self upPay];
            } else if (_alipayButton.selected) {
                [self aliPay];
            }
        }
            break;
        default:
            break;
    }
}

/*
 * 银联支付
 */
- (void)upPay
{
    NSDictionary *dic = @{@"user_id": [Common getUser].user_id,
                          @"type": @"yinlian",
                          @"amount": self.cxParams.amount,
                          @"gateway": @"yinlian_ccb",
                          @"cp_bill_no": self.cxParams.cp_bill_no,
                          @"notify_url": self.cxParams.notify_url,
                          @"extra": self.cxParams.extra,
                          };
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"pay/unionpay" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if(code == 1) {
                NSDictionary *dic = [responseObj objectForKey:@"data"];
                NSString *tn = [dic objectForKey:@"tn"];
                if ([StringUtil isNotEmpty:tn]) {
                    [UPPayPlugin startPay:tn mode:kUPPayMode viewController:self delegate:self];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"获取TN失败"];
                }
            } else {
                [self showToast:code];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

/*
 * 支付宝
 */
- (void)aliPay
{
    NSDictionary *dic = @{@"user_id": [Common getUser].user_id,
                          @"type": @"ap",
                          @"amount": self.cxParams.amount,
                          @"gateway": @"ap_spt",
                          @"cp_bill_no": self.cxParams.cp_bill_no,
                          @"notify_url": self.cxParams.notify_url,
                          @"extra": self.cxParams.extra,
                          };
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [GGNetWork getHttp:@"pay/alipay" parameters:params sucess:^(id responseObj) {
        if (responseObj) {
            NSInteger code = [[responseObj objectForKey:@"code"] intValue];
            if(code == 1){
                NSDictionary *dic = [responseObj objectForKey:@"data"];
                NSString *order_id = [dic objectForKey:@"order_id"];
                NSString *notify_url = [dic objectForKey:@"notify_url"];
                [self setOrderInfoWithOrderId:order_id notifyURL:notify_url];
            } else {
                [self showToast:code];
            }
        }
    } failed:^(NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:@"链接失败"];
    }];
}

#pragma mark - UPPayPluginDelegate methods
- (void)UPPayPluginResult:(NSString *)result
{
    NSDictionary *dic = @{@"result": result,
                          @"payType": @"unionpay",
                          @"amount": self.cxParams.amount,
                          @"productName": self.cxParams.productName,
                          @"cp_bill_no": self.cxParams.cp_bill_no
                          };
    if ([result isEqualToString:@"success"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PURCHASE_SUCCESSED_NOTIFICATION object:nil userInfo:dic];
        [TalkingDataAppCpa onPay:[Common getUser].user_id withOrderId:self.cxParams.cp_bill_no withAmount:self.cxParams.amount.intValue*100 withCurrencyType:@"CNY" withPayType:@"unionpay"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else if ([result isEqualToString:@"cancel"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PURCHASE_CANCELLED_NOTIFICATION object:nil userInfo:dic];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:PURCHASE_FAILED_NOTIFICATION object:nil userInfo:dic];
    }
}

#pragma mark - aliPay
- (void)setOrderInfoWithOrderId:(NSString *)orderId notifyURL:(NSString *)notifyURL
{
    NSString *partner = @"2088711263088594";
    NSString *seller = @"2088711263088594";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJYYMbBLFoaN2rTBgQjgta1DmXY6yj14VLqIhjt6wAI15qEhGzTf4x78sqkXCRdurEkpLCwBaMxsuU4XoKGBJofj99nt8PSaKu/kYKwZwpaGzKHbz5QTInxIc3rFZNCc8zYU+vA4VwL3Ckdj3iuPFVU1mxV4k2JUAAIkqmWxiGf5AgMBAAECgYBMEUrta8CoxK+4t/DrTOcGPqJB1x2z9Y4LUzGkZ1t0Q1j1BFBDhcwXYj4xj+kdpQtPsLwgOT6hi+CGAVd5QnkB0wHHj2EhJwN7v1EBBu/9ZvBGHPtZ2UIepQ3Ovlamv50nrxKxQuXOmtTXhGLarhG2+x6/BSHStlc5MtbBQHM3GQJBAMdURYtJKc21qOwcCXEhAoLLz1SKkHfZhR5GZdYDTGsyQIAqdlSMo62KUktVaYC9agf8fF1GpxhG8d8ZyOAMqL8CQQDAxHyXPypLbZg3ko53HBhwuqEBUNTFQsTyzR+xmf0/bYHD56SAI3XdjTJE7VV60Sqa8jV+oPIcLxX1n0Gc3iVHAkEAhtgEn+Bjzky5NNkWrhhlqXQVEx0V9G4Ldtqq46ehl9cL+WhAWpw10h2D5ICoebYpt7Nfsn4sZekAkSvRT3hg4wJBAKH39p+2yTjbexymneHiz35YsdPDMSQV+Bny1ICL3MggoPoUdpncMbrYWrajnEE34s6SWPRvEz8vKQpap+zAkx0CQF+PBK6MK59NA9F396o4da2qyGc2q/onMnVAMXqtKHcnWW37ICiuV3Es8j3LbcLOK1wl/vAbFovF5szbdgu1GTw=";
    
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderId; //订单ID(由商家□自□行制定)
    order.productName = self.cxParams.productName; //商品标题
    order.productDescription = self.cxParams.productDescription; //商品描述
    order.amount = self.cxParams.amount; //商品价格
    order.notifyURL = notifyURL; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";

    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = self.cxParams.appScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            [self progressPaymentWithResultDic:resultDic];
        }];
    }
}

#pragma mark - purchasePaymentResultNotification
- (void)purchasePaymentResult:(NSNotification *)notification
{
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    NSURL *resultUrl = notification.object;
    if ([resultUrl.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:resultUrl standbyCallback:^(NSDictionary *resultDic) {
            [self progressPaymentWithResultDic:resultDic];
        }];
    }
    //支付宝钱包快登授权返回 authCode
    if ([resultUrl.host isEqualToString:@"platformapi"]) {
        [[AlipaySDK defaultService] processAuthResult:resultUrl standbyCallback:^(NSDictionary *resultDic) {
            [self progressPaymentWithResultDic:resultDic];
        }];
    }
}

//处理支付宝回调
- (void)progressPaymentWithResultDic:(NSDictionary *)resultDic
{
    NSDictionary *dic = @{@"result": [resultDic objectForKey:@"result"],
                          @"resultStatus": [resultDic objectForKey:@"resultStatus"],
                          @"payType": @"alipay",
                          @"amount": self.cxParams.amount,
                          @"productName": self.cxParams.productName,
                          @"cp_bill_no": self.cxParams.cp_bill_no
                          };
    NSString *resultState = [resultDic objectForKey:@"resultStatus"];
    if ([resultState isEqualToString:@"9000"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PURCHASE_SUCCESSED_NOTIFICATION object:nil userInfo:dic];
        [TalkingDataAppCpa onPay:[Common getUser].user_id withOrderId:self.cxParams.cp_bill_no withAmount:self.cxParams.amount.intValue*100 withCurrencyType:@"CNY" withPayType:@"alipay"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else if ([resultState isEqualToString:@"6001"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:PURCHASE_CANCELLED_NOTIFICATION object:nil userInfo:dic];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:PURCHASE_FAILED_NOTIFICATION object:nil userInfo:dic];
    }
}

#pragma mark - interfaceOrientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
