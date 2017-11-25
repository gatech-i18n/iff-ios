//
//  BasicInfoViewController.h
//  iff
//
//  Created by Binchen Hu on 9/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityUser.h>

@class IFFProfile;

@interface QuestionViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>

@property NSUInteger questionIndex;

@property (strong, nonatomic) NSString *answer;
@property (nonatomic, strong) AWSCognitoIdentityUserSession *session;

@property (weak, nonatomic) IBOutlet UIPickerView *countryPicker1;
@property (weak, nonatomic) IBOutlet UIPickerView *countryPicker2;

@property (strong, nonatomic) IFFProfile *profile;
@property (strong, nonatomic) IBOutlet UITextView *interestField;
@property (strong, nonatomic) IBOutlet UITextView *introField;

@end
