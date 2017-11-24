//
//  BasicViewController.m
//  iff
//
//  Created by Binchen Hu on 9/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "BasicInfoViewController.h"

#import "PROFILEProfile.h"
#import "QuestionViewController.h"
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"question"]) {
        QuestionViewController *vc = (QuestionViewController *)[segue destinationViewController];
        PROFILEProfile *profile = [PROFILEProfile new];
        profile.fullName = [_firstName.text stringByAppendingString:_lastName.text];
        profile.homeCountry = _country.text;
        profile.gender = _female.selectedButton.titleLabel.text;
        vc.profile = profile;
    }
}


@end

