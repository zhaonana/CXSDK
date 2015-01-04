//
//  GGNetWork.m
//  GGNetWorkEngineV1.0
//
//  Created by Static Ga on 13-11-14.
//  Copyright (c) 2013年 Static Ga. All rights reserved.
//

#import "GGNetWork.h"
#import "GGHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import <CommonCrypto/CommonHMAC.h>
#import "NSData+Base64.h"
#import "SVProgressHUD.h"
#import "NSObject+JSONCategories.h"
#import "NSString+JSONCategories.h"
#import "DeviceInfo.h"
#import "CXCommon.h"

@implementation GGNetWork

NSString* generateSignature(NSString *userId, NSString *secret)
{
    const char *keyBytes = [secret cStringUsingEncoding:NSUTF8StringEncoding];
    const char *baseStringBytes = [userId cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char digestBytes[CC_SHA1_DIGEST_LENGTH];
    
    CCHmacContext ctx;
    CCHmacInit(&ctx, kCCHmacAlgSHA1, keyBytes, strlen(keyBytes));
    CCHmacUpdate(&ctx, baseStringBytes, strlen(baseStringBytes));
    CCHmacFinal(&ctx, digestBytes);
    
    NSData *digestData = [NSData dataWithBytes:digestBytes length:CC_SHA1_DIGEST_LENGTH];
    NSString *signature = [digestData base64Encoding];
   
    signature = [signature stringByReplacingOccurrencesOfString:@"+" withString:@"*"];
    signature = [signature stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    return signature;
}

NSString* HMAC_SHA1SignatureForText(NSString *text, NSString *secret) {

	NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
	NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
    
	CCHmacContext hmacContext;
	bzero(&hmacContext, sizeof(CCHmacContext));
    CCHmacInit(&hmacContext, kCCHmacAlgSHA1, secretData.bytes, secretData.length);
    CCHmacUpdate(&hmacContext, textData.bytes, textData.length);
    CCHmacFinal(&hmacContext, result);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", result[i]];
    
    return output;
}

+ (void)postHttp:(NSString *)path parameters:(NSDictionary *)par sucess:(GGSucessBlock)sucessBlock
          failed:(GGFailedBlock)failedBlock {
    [SVProgressHUD showWithStatus:@"加载中" maskType:4];
    
    [GGHTTPClient client].parameterEncoding = AFJSONParameterEncoding;

    [[GGHTTPClient client] postPath:path parameters:par success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        //处理status
        NSLog(@"responseObject %@",responseObject);
        if (responseObject) {
            id error = [responseObject objectForKey:@"error"];
            if (error) {
                id message = [error objectForKey:@"message"];
                if (message) {
                    [SVProgressHUD showErrorWithStatus:message];
                }
            }else {
                if (sucessBlock) {
                    sucessBlock(responseObject);
                }
            }
        }else {
            if (failedBlock) {
                failedBlock(@" ");
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        
        NSLog(@"error %@",error);
        NSLog(@"opear %@",operation.responseString);
        if (operation.responseString) {
            id obj = [operation.responseString JSONValue];
            NSLog(@"obj %@",obj);
            if (obj) {
                NSDictionary *error = [obj objectForKey:@"error"];
                if (error) {
                    
                    NSString *memo = [error objectForKey:@"memo"];
                    if (memo) {
                        [SVProgressHUD showErrorWithStatus:memo];
                    }
                }
            }
        }else {
            [SVProgressHUD showErrorWithStatus:@"无法连接到服务器"];
        }


        if (failedBlock) {
            failedBlock(error.localizedDescription);
        }
        
    }];
    
}

+ (void)getHttp:(NSString *)path parameters:(NSMutableDictionary *)par sucess:(GGSucessBlock)sucessBlock failed:(GGFailedBlock)failedBlock {
    
    NSString *phoneVer = [[UIDevice currentDevice] systemVersion];
    NSString *deviceName = [DeviceInfo getDeviceVersion];
    NSMutableDictionary *infoDic = [USER_DEFAULT objectForKey:INITINFO];

    NSDictionary *dic = @{@"app_id": [infoDic objectForKey:@"appID"],
                          @"server_id": [infoDic objectForKey:@"serviceID"],
                          @"os_version": phoneVer,
                          @"system": @"ios",
                          @"imei": [DeviceInfo getIDFA],
                          @"device_name": deviceName
                          };
    if (par.allKeys.count != 1 || ![[par.allKeys objectAtIndex:0] isEqualToString:@"imei"]) {
        [par addEntriesFromDictionary:dic];
    }

    [SVProgressHUD showWithStatus:@"加载中" maskType:4];

    [GGHTTPClient client].parameterEncoding = AFFormURLParameterEncoding;

    [[GGHTTPClient client] getPath:path parameters:par success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        //处理status
        NSLog(@"responseObject %@",responseObject);
        if (responseObject) {
            id error = [responseObject objectForKey:@"error"];
            if (error) {
                id message = [error objectForKey:@"message"];
                if (message) {
                    [SVProgressHUD showErrorWithStatus:message];
                }
            }else {
                if (sucessBlock) {
                    sucessBlock(responseObject);
                }
            }
        } else {
            if (failedBlock) {
                failedBlock(@" ");
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"opear %@",operation.responseString);
        [SVProgressHUD dismiss];
        if (operation.responseString) {
            id obj = [operation.responseString JSONValue];
            NSLog(@"obj %@",obj);
            if (obj) {
                NSDictionary *error = [obj objectForKey:@"error"];
                if (error) {
                    NSString *memo = [error objectForKey:@"memo"];
                    if (memo) {
                        [SVProgressHUD showErrorWithStatus:memo];
                    }
                }
            }
        }else {
            [SVProgressHUD showErrorWithStatus:@"无法连接到服务器"];
        }
        
        if (failedBlock) {
            failedBlock(error.localizedDescription);
        }

    }];
}

@end
