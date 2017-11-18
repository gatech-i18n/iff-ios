#import "QuestionViewController.h"

#import "PROFILEIFFClient.h"
#import "PROFILEProfile.h"

#import <AWSCore/AWSTask.h>
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface QuestionViewController() {
    NSArray *_countries;
}
@property (nonatomic, strong) AWSCognitoIdentityUser *user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool *pool;
@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _countries = @[@"United States", @"China", @"United Kindom"];
    
    self.countryPicker.dataSource = self;
    self.countryPicker.delegate = self;
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
    
//    _answer = [_countries objectAtIndex:[self.countryPicker selectedRowInComponent:0]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

- (IBAction)submitProfile:(id)sender {
    PROFILEIFFClient *profileAPI = [PROFILEIFFClient defaultClient];
    
    PROFILEProfile *profile = [PROFILEProfile new];
    
    profile.profileId = @"test2";
    profile.fullName = @"Williams Chen";
    profile.homeCountry = @"United States";
    profile.gender = @"M";
    profile.reason = @"I want to explore different cultures!";
    profile.interests = @[@"basketball", @"eat"];
    profile.desiredCountries = @[@"China", @"Italy"];
    
    [[profileAPI profilePost:[self.session.idToken tokenString] body:profile] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
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

@end

