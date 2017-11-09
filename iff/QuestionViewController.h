//
//  BasicInfoViewController.h
//  iff
//
//  Created by Binchen Hu on 9/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityUser.h>

@interface QuestionViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property NSUInteger questionIndex;

@property (strong, nonatomic) NSString *answer;
@property (nonatomic, strong) AWSCognitoIdentityUserSession *session;

@property (weak, nonatomic) IBOutlet UIPickerView *countryPicker;

@end
