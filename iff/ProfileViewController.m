
#import "ProfileViewController.h"

#import "IFFIFFClient.h"
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface ProfileViewController ()

@property (nonatomic, strong) IFFProfile *profile;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    if (!self.user) {
        self.user = [self.pool currentUser];
    }
    [self loadProfile];
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
    IFFIFFClient *profileAPI = [IFFIFFClient defaultClient];
    _profileUsername = _profileUsername == nil ? self.user.username : _profileUsername;
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

- (void)configureProfile:(IFFProfile *)profile {
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


