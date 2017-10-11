//
//  ViewController.h
//  iff
//
//  Created by tomoreoreo on 8/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface ViewController : UIViewController<AWSCognitoIdentityPasswordAuthentication>

@property (strong, nonatomic) IBOutlet UITextField *userEmailField; 

@property (strong, nonatomic) IBOutlet UITextField *userPasswordField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails*>* passwordAuthenticationCompletion;

@end

