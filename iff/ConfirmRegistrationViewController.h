//
//  ConfirmRegistrationViewController.h
//  iff
//
//  Created by Binchen Hu on 10/27/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@class UserProfile;

@interface ConfirmRegistrationViewController : UIViewController

@property (nonatomic, strong) AWSCognitoIdentityUser *user;
@property (nonatomic, strong) NSString *sentTo;
@property (nonatomic, strong) UserProfile *userProfile;
@property (nonatomic, strong) NSString *password;

@end
