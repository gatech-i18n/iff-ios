//
//  RegisterViewController.m
//  iff
//
//  Created by tomoreoreo on 9/9/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "RegisterViewController.h"

#import "DashboardViewController.h"

#import <AWSCore/AWSService.h>
#import <AWSCognito/AWSCognito.h>
#import <AWSCognito/AWSCognitoService.h>
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityUser.h>
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityUserPool.h>

@implementation RegisterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleRegister:(id)sender {
    //setup service config
    AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1 credentialsProvider:nil];
    
    //create a pool
    AWSCognitoIdentityUserPoolConfiguration *configuration = [[AWSCognitoIdentityUserPoolConfiguration alloc]
                                                              initWithClientId:@"5cgmr8db2jspjfmbkff1h1acks"
                                                              clientSecret:@"120fqkrutq6c3dum0d91paqc475430h2sumbl7olm81bpq5tpuln"
                                                              poolId:@"us-west-2_xSVg8gk68"];
    [AWSCognitoIdentityUserPool registerCognitoIdentityUserPoolWithConfiguration:serviceConfiguration userPoolConfiguration:configuration forKey:@"UserPool"];
    AWSCognitoIdentityUserPool *pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    
    NSMutableArray * attributes = [NSMutableArray new];

    AWSCognitoIdentityUserAttributeType * email = [AWSCognitoIdentityUserAttributeType new];
    email.name = @"email";
    email.value = _userEmailField.text;
    
    [attributes addObject:email];
    
    [pool signUp:_userEmailField.text password:_userPassword.text userAttributes:@[email] validationData:nil];

    [self performSegueWithIdentifier:@"afterRegister" sender:_userEmailField];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"afterRegister"]) {
        DashboardViewController *dashboard = (DashboardViewController *)[segue destinationViewController];
        dashboard.userInfo = _userEmailField.text;
    }
}

@end

