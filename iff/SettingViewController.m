//
//  SettingViewController.m
//  iff
//
//  Created by Binchen Hu on 10/10/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//
#import "SettingViewController.h"

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>
#import <Foundation/Foundation.h>

@interface SettingViewController ()
@property (nonatomic,strong) AWSCognitoIdentityUserGetDetailsResponse * response;
@property (nonatomic, strong) AWSCognitoIdentityUser * user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;
@end


@implementation SettingViewController
{
    NSArray *tableData;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    //on initial load set the user and refresh to get attributes
    if(!self.user)
        self.user = [self.pool currentUser];
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

- (IBAction)logout:(id)sender {
    [self.user signOut];
    self.response = nil;
    [self.view reloadInputViews];
    [self refresh];
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

