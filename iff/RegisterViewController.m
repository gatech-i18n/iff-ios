//
//  RegisterViewController.m
//  iff
//
//  Created by tomoreoreo on 9/9/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "RegisterViewController.h"

#import "DashboardViewController.h"

@implementation RegisterViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"afterRegister"]) {
        DashboardViewController *dashboard = (DashboardViewController *)[segue destinationViewController];
        dashboard.userInfo = _userEmailField.text;
    }
}

@end

