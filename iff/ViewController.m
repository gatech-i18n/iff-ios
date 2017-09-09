//
//  ViewController.m
//  iff
//
//  Created by tomoreoreo on 8/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "ViewController.h"

#import "DashboardViewController.h"

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
    [self performSegueWithIdentifier:@"LoginToDashboard" sender:_userEmailField];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LoginToDashboard"]) {
        DashboardViewController *dashboard = (DashboardViewController *)[segue destinationViewController];
        dashboard.userInfo = _userEmailField.text;
    }
}

@end
