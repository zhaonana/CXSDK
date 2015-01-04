//
//  NSString+JSONCategories.m
//  Echo
//
//  Created by Static Ga on 13-11-20.
//  Copyright (c) 2013年 Static Ga. All rights reserved.
//

#import "NSString+JSONCategories.h"

@implementation NSString (JSONCategories)
- (id)JSONValue;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end
