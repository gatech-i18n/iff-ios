//
//  SettingViewController.m
//  iff
//
//  Created by Binchen Hu on 10/10/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//
#import "SettingViewController.h"

#import <Foundation/Foundation.h>

@implementation SettingViewController
{
    NSArray *tableData;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tableData = [NSArray arrayWithObjects:@"Logout", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
