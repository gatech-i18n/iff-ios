//
//  BasicInfoViewController.h
//  iff
//
//  Created by Binchen Hu on 9/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DLRadioButton.h"
#import "UserProfile.h"
@class AWSCognitoIdentityUser;

@interface BasicInfoViewController : UIViewController

@property (nonatomic, strong) UserProfile *userProfile;
@property (nonatomic, strong) AWSCognitoIdentityUser *user;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet DLRadioButton *female;
@property (strong, nonatomic) IBOutlet DLRadioButton *male;
@property (strong, nonatomic) IBOutlet DLRadioButton *other;

@end

