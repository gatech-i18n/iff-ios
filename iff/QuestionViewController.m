#import "QuestionViewController.h"

#import "IFFIFFClient.h"
#import "IFFProfile.h"

#import <AWSCore/AWSTask.h>
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface QuestionViewController() {
    NSArray *_countries;
}
@property (nonatomic, strong) AWSCognitoIdentityUser *user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool *pool;
@property (nonatomic, strong) NSString *selectedCountry1;
@property (nonatomic, strong) NSString *selectedCountry2;
@property (nonatomic, strong) NSString *userid;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (_introField) {
        _introField.delegate = self;
        _introField.text = @"Tip: A great introduction includes why you are on IFF Connect, your favorite hobbies, and what you would like to share ";
        _introField.textColor = [UIColor lightGrayColor];
    }
    if (_interestField) {
        _interestField.delegate = self;
        _interestField.text = @"Please add up to 10 interests. Sperate by commas.";
        _interestField.textColor = [UIColor lightGrayColor];
    }
    _countries = @[@"Please select a country", @"Japan", @"Canada", @"Spain", @"France", @"Italy", @"Germany", @"Mexico", @"Thailand", @"Morocco", @"Egypt", @"South Africa", @"Brazil", @"Argentina", @"Dominican Republic", @"Chile", @"Puerto Rico", @"Cuba", @"Peru", @"Thailand", @"Malaysia", @"South Korea", @"India", @"Singapore", @"Indonesia", @"Turkey", @"Austria", @"Greece", @"Russia", @"Poland", @"Colombia", @"Panam", @"Costa Rica", @"United States", @"China", @"United Kindom"];
    
    self.countryPicker1.dataSource = self;
    self.countryPicker1.delegate = self;
    self.countryPicker2.dataSource = self;
    self.countryPicker2.delegate = self;
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    //on initial load set the user and refresh to get attributes
    if(!self.user) {
        self.user = [self.pool currentUser];
    }

    [[self.user getSession] continueWithSuccessBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserSession *> * _Nonnull task) {
        if (task.error) {
            NSLog(@"%@", task.error);
        } else {
            self.session = task.result;
        }
        return nil;
    }];
    [[self.user getDetails] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserGetDetailsResponse *> * _Nonnull task) {
        if (task.error) {
            NSLog(@"%@", task.error);
        } else {
            [[task.result userAttributes] enumerateObjectsUsingBlock:^(AWSCognitoIdentityProviderAttributeType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.name isEqualToString:@"custom:userid"]) {
                    self.userid = obj.value;
                }
            }];
            
        }
        return nil;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Picker View Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _countries.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _countries[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == _countryPicker1) {
        _selectedCountry1 = _countries[row];
    }
    if (pickerView == _countryPicker2) {
        _selectedCountry2 = _countries[row];
    }
}

- (IBAction)submitProfile:(id)sender {
    IFFIFFClient *profileAPI = [IFFIFFClient defaultClient];

    _profile.profileId = [self.user username];
    _profile.reason = _introField.text;

    [[profileAPI profilePost:[self.session.idToken tokenString] body:_profile] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
        if (task.error) {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:task.error.userInfo[@"x-cache"]
                                          message:task.error.userInfo[@"x-amzn-errortype"]
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alert addAction:ok];
            
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        return nil;
    }];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QuestionViewController *nextVC = (QuestionViewController *)[segue destinationViewController];
    if (!_profile) {
        _profile = [IFFProfile new];
    }
    if ([segue.identifier isEqualToString:@"addInterests"]) {
        _profile.desiredCountries = @[_selectedCountry1, _selectedCountry2];
    } else if ([segue.identifier isEqualToString:@"chooseReason"]) {
        _profile.interests = [_interestField.text componentsSeparatedByString:@","];
    } else if ([segue.identifier isEqualToString:@"introduction"]) {
        _profile.reason = @"";
    }
    nextVC.profile = _profile;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Placeholder";
        textView.textColor =[UIColor lightGrayColor];
    }
}

@end

