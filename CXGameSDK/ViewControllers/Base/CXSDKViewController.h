//
//  CXSDKViewController.h
//  CXGameSDK1.0
//
//  Created by NaNa on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXComPlatformBase.h"
/**
 *  界面type
 *
 *  @return 每个界面
 */
#define TYPE_LOGIN           0
#define TYPE_USER_LOGIN      1
#define TYPE_REGISTER        2
#define TYPE_ISBIND_PHONE    3
#define TYPE_CHANGE_PASSWROD 4
#define TYPE_TOURISTS_LOGIN  5
#define TYPE_BIND_PHONE      6
#define TYPE_FORGOT_PASSWORD 7
#define TYPE_RESET_PASSWORD  8


/**
 *  畅想游戏SDK接口类
 */
@interface CXSDKViewController : UIViewController

/**
 *  游戏合作商秘钥
 */
@property (nonatomic, strong) NSString         *cpKey;
/**
 *  服务器ID
 */
@property (nonatomic, strong) NSString         *serverID;
/**
 *  应用ID
 */
@property (nonatomic, strong) NSString         *appID;
/**
 *  子界面
 */
@property (nonatomic, strong) UIViewController *controller;

/**
 *  初始化SDK
 *
 *  @param controller 自己的控制器 传self
 */
- (void)initSDK:(UIViewController*)controller;
/**
 *  打开SDK
 *
 *  @param controller 自己的控制器 传self
 */
- (void)openSDK:(UIViewController *)controller;

/**
 *  关闭SDK
 */
- (void)closeSDK;
/**
 *  隐藏SDK
 */
- (void)hiddenSDK;
/**
 *  显示SDK
 */
- (void)showSDK;

/**
 *  按照Tag显示界面()
 *
 *  @param tag 界面type
 */
- (void)showTabByTag:(NSInteger)tag;

@end
