//
//  GGHTTPClient.m
//  GGNetWorkEngineV1.0
//
//  Created by Static Ga on 13-11-14.
//  Copyright (c) 2013年 Static Ga. All rights reserved.
//

#import "GGHTTPClient.h"
#import "AFJSONRequestOperation.h"

#define kBaseURL @"http://sdkapi.ak.cc"
//#define kBaseURL @"http://sdkapi.test.ak.cc"
//#define kBaseURL @"http://14.17.126.90:8091"

@implementation GGHTTPClient

+ (instancetype)client {
    static GGHTTPClient *myClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myClient = [GGHTTPClient clientWithBaseURL:[NSURL URLWithString:kBaseURL]];
        [myClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [myClient setDefaultHeader:@"Accept" value:@"application/json"];
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
//        [myClient setDefaultHeader:@"Accept" value:@"text/html"];
    });
    return myClient;
}

@end
