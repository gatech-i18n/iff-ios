//
//  DashboardViewController.m
//  iff
//
//  Created by tomoreoreo on 9/8/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "DashboardViewController.h"

#import "NoRecommendationView.h"
#import "PROFILEProfile.h"
#import "PROFILEIFFClient.h"
#import "ProfileViewController.h"

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface DashboardViewController ()
@property (nonatomic,strong) AWSCognitoIdentityUserGetDetailsResponse * response;
@property (nonatomic, strong) AWSCognitoIdentityUser * user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;
@end

@implementation DashboardViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    //on initial load set the user and refresh to get attributes
    if (!self.user) {
        self.user = [self.pool currentUser];
    }
    [self refresh];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"otherprofile"]) {
        PROFILEIFFClient *profileAPI = [PROFILEIFFClient defaultClient];
        ProfileViewController *profileVC = (ProfileViewController *)[segue destinationViewController];
        [[profileAPI profileUsernameGet:@"abc123"] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
            if (task.error) {
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:task.error.userInfo[@"x-cache"]
                                              message:task.error.userInfo[@"x-amzn-errortype"]
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                     }];
                
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                PROFILEProfile *profile = task.result;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [profileVC configureProfile:profile];
                });
            }
            return nil;
        }];
    }
}

- (void)refresh {
    [[self.user getDetails] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserGetDetailsResponse *> * _Nonnull task) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (task.error) {
                self.title = task.error.userInfo[@"__type"];
                if(self.title == nil){
                    self.title = task.error.userInfo[NSLocalizedDescriptionKey];
                }
                [self.navigationController setToolbarHidden:YES];
            } else {
                self.response = task.result;
                [self.view reloadInputViews];
                [self.navigationController setToolbarHidden:NO];
            }
        });
        
        return nil;
    }];
}

@end
