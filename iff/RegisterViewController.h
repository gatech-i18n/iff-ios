//
//  RegisterViewController.h
//  iff
//
//  Created by tomoreoreo on 9/9/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AWSCognitoIdentityUserPool;

@interface RegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *userEmailField;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) IBOutlet UITextField *userPasswordConfirm;

@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;
@property (nonatomic, strong) NSString* sentTo;

@end
