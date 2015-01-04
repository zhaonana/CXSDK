//
//  ChangePasswordViewController.h
//  BXGameSDK1.0
//
//  Created by JZY on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePasswordViewController : BaseViewController

@property (nonatomic, strong) IBOutlet UITextField *tfOldPassword;
@property (nonatomic, strong) IBOutlet UITextField *tfNewPassword;
@property (nonatomic, strong) IBOutlet UITextField *tfCfmPassword;

@end
