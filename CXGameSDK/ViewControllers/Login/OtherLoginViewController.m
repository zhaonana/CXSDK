//
//  OtherLoginViewController.m
//  CXGameSDK
//
//  Created by NaNa on 14-10-29.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "OtherLoginViewController.h"
#import "CXCommon.h"
#import "DeviceInfo.h"
#import "TalkingDataAppCpa.h"

#define kBaseURL @"http://sdkapi.ak.cc"
//#define kBaseURL @"http://sdkapi.test.ak.cc"
//#define kBaseURL @"http://14.17.126.90:8091"

@interface OtherLoginViewController () <UIWebViewDelegate>

@end

@implementation OtherLoginViewController

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
    
    self.title = @"新浪微博";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // no transforms applied to window in iOS 8, but only if compiled with iOS 8 sdk as base sdk, otherwise system supports old rotation logic.
    BOOL ignoreOrientation = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[NSProcessInfo processInfo] respondsToSelector:@selector(operatingSystemVersion)]) {
        ignoreOrientation = YES;
    }
#endif
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect frame = CGRectMake(0, 0, 0, 0);
    if (ignoreOrientation) {
        frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
    } else {
        switch (interfaceOrientation) {
            case UIInterfaceOrientationLandscapeLeft:
                frame = CGRectMake(0, 0, KSCREENHEIGHT, KSCREENWIDTH);
                break;
            case UIInterfaceOrientationLandscapeRight:
                frame = CGRectMake(0, 0, KSCREENHEIGHT, KSCREENWIDTH);
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
                break;
            default:
                frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
                break;
        }
    }
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    [webView setDelegate:self];
    
    NSString *phoneVer = [[UIDevice currentDevice] systemVersion];
    NSString *deviceName = [DeviceInfo getDeviceVersion];
    NSMutableDictionary *infoDic = [USER_DEFAULT objectForKey:INITINFO];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/user/threelogin?client=%@&app_id=%@&server_id=%@&device_name=%@&os_version=%@&imei=%@",kBaseURL,self.client,[infoDic objectForKey:@"appID"],[infoDic objectForKey:@"serviceID"],deviceName,phoneVer,[DeviceInfo getIDFA]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButtonClick
- (void)barButtonClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        if (self.cancelOtherLoginBlock) {
            self.cancelOtherLoginBlock();
        }
    }];
}

#pragma mark - UIWebViewDelegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];

    if ([url.scheme isEqualToString:@"cxapi"]) {
        NSString *jsonStr = [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSRange range = [jsonStr rangeOfString:@"{"];
        if (range.location != NSNotFound) {
            jsonStr = [jsonStr substringFromIndex:range.location];
        }
        NSData *jsonData = [jsonStr dataUsingEncoding:NSASCIIStringEncoding];
        NSDictionary *dic = [JsonUtil toArrayOrNSDictionary:jsonData];
        UserModel *user = [JsonUtil parseUserModel:dic];
        
        if (self.loginSuccessedBlock) {
            self.loginSuccessedBlock(user.user_id, user.ticket);
        }

        //保存账户密码
        [self saveUsers:user];
        //设置当前用户信息
        [Common setUser:user];
        //TD
        [TalkingDataAppCpa onLogin:user.user_id];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return YES;
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

@end
