//
//  NSObject+JSONCategories.m
//  Echo
//
//  Created by Static Ga on 13-11-20.
//  Copyright (c) 2013年 Static Ga. All rights reserved.
//

#import "NSObject+JSONCategories.h"

@implementation NSObject (JSONCategories)
- (NSData *)JSONData;
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

- (NSString *)JSONString;
{
    NSData *jsonData = [self JSONData];
    NSString *jsonString = nil;
    

    if ([jsonData length] > 0) {
        jsonString = [[NSString alloc] initWithData:jsonData
                              encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
