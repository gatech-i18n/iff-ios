//
//  DashboardViewController.m
//  iff
//
//  Created by tomoreoreo on 9/8/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "DashboardViewController.h"

@implementation DashboardViewController

@synthesize userInfoLabel = _userInfoLabel;

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _userInfoLabel.text = [_userInfo componentsSeparatedByString:@"@"][0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
