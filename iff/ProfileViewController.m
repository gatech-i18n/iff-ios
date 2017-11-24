
#import "ProfileViewController.h"

#import "PROFILEIFFClient.h"
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface ProfileViewController ()

@property (nonatomic, strong) PROFILEProfile *profile;
@property (nonatomic, strong) NSString *userid;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof(self) weakSelf = self;
    [[self.user getDetails] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserGetDetailsResponse *> * _Nonnull task) {
        if (task.error) {
            NSLog(@"%@", task.error);
        } else {
            [[task.result userAttributes] enumerateObjectsUsingBlock:^(AWSCognitoIdentityProviderAttributeType * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.name isEqualToString:@"custom:userid"]) {
                    self.userid = obj.value;
                    *stop = YES;
                }
            }];
            [weakSelf loadProfile];
        }
        return nil;
    }];
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    if (!self.user) {
        self.user = [self.pool currentUser];
    }
   
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadProfile {
    PROFILEIFFClient *profileAPI = [PROFILEIFFClient defaultClient];
    _profileUsername = _profileUsername == nil ? self.userid : _profileUsername;
    __weak typeof(self) weakSelf = self;
    [[profileAPI profileUsernameGet:_profileUsername] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
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
            self.profile = task.result;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf configureProfile:self.profile];
            });
        }
        return nil;
    }];
    
}

- (void)configureProfile:(PROFILEProfile *)profile {
    _profileName.text = profile.fullName;
    _homeCountry.text = profile.homeCountry;
    _reason.text = profile.reason;
    _country1.text = profile.desiredCountries[0];
    _country2.text = profile.desiredCountries[1];
    _gender.image = [profile.gender isEqualToString:@"F"] ? [UIImage imageNamed:@"female"] : [UIImage imageNamed:@"male"];
    _interests.text = @"";
    for (NSString *i in profile.interests) {
        _interests.text = [_interests.text stringByAppendingString:[NSString stringWithFormat:@"%@\t", i]];
    }
}

@end


