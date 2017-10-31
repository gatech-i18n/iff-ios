//
//  BasicViewController.m
//  iff
//
//  Created by Binchen Hu on 9/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "BasicInfoViewController.h"

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityUser.h>
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityUserPool.h>
#import <AWSCore/AWSTask.h>

@interface BasicInfoViewController ()
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;
@end

@implementation BasicInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    //on initial load set the user and refresh to get attributes
    if (!self.user) {
        self.user = [self.pool currentUser];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

