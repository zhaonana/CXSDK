//
//  BPPurchaseHelper.h
//  CXGameSDK
//
//  Created by NaNa on 14/12/30.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXPayParams.h"

//支付成功通知
#define PURCHASE_SUCCESSED_NOTIFICATION @"purchaseSucessedNotification"
//支付失败通知
#define PURCHASE_FAILED_NOTIFICATION @"purchaseFailedNotification"
//支付取消通知
#define PURCHASE_CANCELLED_NOTIFICATION @"purchasecancelledNotification"

@interface BPPurchaseHelper : NSObject

/**
 *  创建支付
 *
 *  @return 支付对象
 */
+ (BPPurchaseHelper *)sharedHelper;
/**
 *  设置支付参数
 *
 *  @param params 支付参数
 */
- (void)setCXPayParams:(CXPayParams *)params;

@end
