//
//  RegisterViewController.m
//  iff
//
//  Created by tomoreoreo on 9/9/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "RegisterViewController.h"

#import "DashboardViewController.h"

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@implementation RegisterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleRegister:(id)sender {
    

    NSMutableArray * attributes = [NSMutableArray new];

    AWSCognitoIdentityUserAttributeType * email = [AWSCognitoIdentityUserAttributeType new];
    email.name = @"email";
    email.value = _userEmailField.text;

    [attributes addObject:email];

    //sign up the user
    [[self.pool signUp:self.userEmailField.text password:self.userPassword.text userAttributes:attributes validationData:nil] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserPoolSignUpResponse *> * _Nonnull task) {
        NSLog(@"Successful signUp user: %@",task.result.user.username);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (task.error) {
//                __weak typeof(self) weakSelf = self;
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:task.error.userInfo[@"__type"]
                                              message:task.error.userInfo[@"message"]
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
//                                         [weakSelf dismissViewControllerAnimated:YES completion:nil];
                                     }];
                
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
            } else if (task.result.user.confirmedStatus != AWSCognitoIdentityUserStatusConfirmed) {
                self.sentTo = task.result.codeDeliveryDetails.destination;
                //[self performSegueWithIdentifier:@"cancelRegister" sender:sender];
            } else {
                //[self presentViewController:self.navigationController.viewControllers[2] animated:YES completion:nil];
                [self performSegueWithIdentifier:@"AddInfo" sender:sender];
            }});
        return nil;
    }];
}


@end

