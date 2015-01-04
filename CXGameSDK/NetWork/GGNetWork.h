//
//  GGNetWork.h
//  GGNetWorkEngineV1.0
//
//  Created by Static Ga on 13-11-14.
//  Copyright (c) 2013年 Static Ga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGTypeDef.h"

@interface GGNetWork : NSObject

/**
 *  Make Signature
 *
 *  @param text   text to sign.
 *  @param secret the secret-key
 *
 *  @return signedString
 */
NSString* HMAC_SHA1SignatureForText(NSString *text, NSString *secret) ;
/**
 *  Http Post
 *
 *  @param path        Http path,for example:Base URL is http://example.com/v1/, the path is login? or /login.
 *  @param par         parameters to post.
 *  @param sucessBlock sucess block to transfer object - JSON.
 *  @param failedBlock failed block to transfer error.
 */
+ (void)postHttp:(NSString *)path parameters:(NSDictionary *)par sucess:(GGSucessBlock)sucessBlock
          failed:(GGFailedBlock)failedBlock;

/**
 *  Http Get .
 *
 *  @param path        Http path.
 *  @param par         parameters. (url form)
 *  @param sucessBlock sucess block to transfer object - JSON.
 *  @param failedBlock failed block to transfer error.
 */
+ (void)getHttp:(NSString *)path parameters:(NSMutableDictionary *)par sucess:(GGSucessBlock)sucessBlock
         failed:(GGFailedBlock)failedBlock;

@end
