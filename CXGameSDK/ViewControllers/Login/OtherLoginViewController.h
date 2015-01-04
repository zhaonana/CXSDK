//
//  OtherLoginViewController.h
//  CXGameSDK
//
//  Created by NaNa on 14-10-29.
//  Copyright (c) 2014年 nn. All rights reserved.
//

#import "BaseViewController.h"

@interface OtherLoginViewController : BaseViewController

@property (nonatomic, copy) NSString *client;
@property (nonatomic, copy) void (^cancelOtherLoginBlock)();
@property (nonatomic, copy) void (^loginSuccessedBlock)(NSString *user_id, NSString *ticket);

@end
