//
//  DashboardViewController.h
//  iff
//
//  Created by tomoreoreo on 9/8/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NamecardCell.h"
#import "NoRecommendationView.h"

@interface DashboardViewController : UIViewController

@property (strong, nonatomic) NSString *recommendedUsername;
@property (strong, nonatomic) NSString *penalty;
@property (strong, nonatomic) IBOutlet UIView *namecard;
@property (strong, nonatomic) IBOutlet UIView *buttonView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeCountryLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
