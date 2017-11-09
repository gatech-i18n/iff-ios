//
//  BasicInfoViewController.h
//  iff
//
//  Created by Binchen Hu on 9/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AWSCognitoIdentityUser;
@class UserProfile;

@interface BasicInfoViewController : UIViewController

@property (nonatomic, strong) UserProfile *userProfile;
@property (nonatomic, strong) AWSCognitoIdentityUser *user;
@property (nonatomic, strong) AWSCognitoIdentityUserSession *session;

@end

