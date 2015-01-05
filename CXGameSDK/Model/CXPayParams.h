//
//  CXPayParams.h
//  CXGameSDK
//
//  Created by NaNa on 14-11-5.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  支付参数
 */
@interface CXPayParams : NSObject

/**
 *  应用注册scheme,在CXSDKDemo-Info.plist定义URL types
 */
@property (nonatomic, copy) NSString *appScheme;
/**
 *  价格
 */
@property (nonatomic, copy) NSString *amount;
/**
 *  商品标题
 */
@property (nonatomic, copy) NSString *productName;
/**
 *  商品描述
 */
@property (nonatomic, copy) NSString *productDescription;
/**
 *  CP订单号
 */
@property (nonatomic, copy) NSString *cp_bill_no;
/**
 *  回调URL 如果不设置 请提供同一通知地址给我们 ，通知将统一发送到所提供的地址
 */
@property (nonatomic, copy) NSString *notify_url;
/**
 *  扩展参数 支付成功服务器通知接口将原样返回
 */
@property (nonatomic, copy) NSString *extra;
/**
 *  应用程序调用SDK的当前 UIViewController
 */
@property (nonatomic, strong) UIViewController *controller;


@end
