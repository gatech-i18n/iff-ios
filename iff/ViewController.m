//
//  ViewController.m
//  iff
//
//  Created by tomoreoreo on 8/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleLogin:(id)sender {
    self.passwordAuthenticationCompletion.result = [[AWSCognitoIdentityPasswordAuthenticationDetails alloc] initWithUsername:self.userEmailField.text password:self.userPasswordField.text];
}

# pragma AWSCognitoIdentityPasswordAuthentication

- (void) getPasswordAuthenticationDetails:(AWSCognitoIdentityPasswordAuthenticationInput *)authenticationInput passwordAuthenticationCompletionSource:(AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails *> *)passwordAuthenticationCompletionSource
{
    self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.userEmailField.text)
            self.userEmailField.text = authenticationInput.lastKnownUsername;
    });
}

- (void) didCompletePasswordAuthenticationStepWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:error.userInfo[@"__type"]
                                          message:error.userInfo[@"message"]
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* retry = [UIAlertAction
                                    actionWithTitle:@"Retry"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                    }];
            
            [alert addAction:retry];

            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

@end
