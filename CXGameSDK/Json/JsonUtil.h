//
//  JsonUtil.h
//  BXGameSDK
//
//  Created by JZY on 14-2-17.
//  Copyright (c) 2014年 jzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface JsonUtil : NSObject

+ (UserModel *)parseUserModel:(id) data;

+ (NSMutableArray *)parseUserModelArray:(id)data;

+ (NSString *)toUserArrayJson:(NSArray*)array;

+ (NSMutableArray *)parseUserModelArrayStr:(NSArray *)array;

+ (NSString *)toJson:(id)data;

+ (id)toArrayOrNSDictionary:(NSData *)jsonData;

@end
