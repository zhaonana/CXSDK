//
//  BPPurchaseHelper.m
//  CXGameSDK
//
//  Created by NaNa on 14/12/30.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "BPPurchaseHelper.h"
#import "PayViewController.h"
#import "BaseNavigationController.h"
#import <AlipaySDK/AlipaySDK.h>

#define PURCHASE_PAYMENTRESULT_NOTIFICATION @"purchasePaymentResultNotification"

@implementation BPPurchaseHelper

static BPPurchaseHelper * _sharedHelper;

+ (BPPurchaseHelper *)sharedHelper
{
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[BPPurchaseHelper alloc] init];
    return _sharedHelper;
}

- (void)setCXPayParams:(CXPayParams *)params
{
    PayViewController *payVC = [[PayViewController alloc] init];
    payVC.cxParams = params;
    [params.controller presentViewController:payVC animated:YES completion:nil];
}

- (void)purchasePaymentResult:(NSURL *)resultUrl
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PURCHASE_PAYMENTRESULT_NOTIFICATION object:resultUrl];
}

@end
