
#import "ProfileViewController.h"

#import "PROFILEIFFClient.h"
#import "UserProfile.h"
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface ProfileViewController ()

@property (nonatomic, strong) PROFILEProfile *profile;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    if (!self.user) {
        self.user = [self.pool currentUser];
    }
//    PROFILEIFFClient *profileAPI = [PROFILEIFFClient defaultClient];
    _profileUsername = _profileUsername == nil ? [self.user username] : _profileUsername;
//    [[profileAPI profileUsernameGet:@"abc123"] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
//        if (task.error) {
//            UIAlertController * alert=   [UIAlertController
//                                          alertControllerWithTitle:task.error.userInfo[@"x-cache"]
//                                          message:task.error.userInfo[@"x-amzn-errortype"]
//                                          preferredStyle:UIAlertControllerStyleAlert];
//
//            UIAlertAction* ok = [UIAlertAction
//                                 actionWithTitle:@"OK"
//                                 style:UIAlertActionStyleDefault
//                                 handler:^(UIAlertAction * action)
//                                 {
//                                     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                                 }];
//
//            [alert addAction:ok];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        } else {
//            self.profile = task.result;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                _intro.text = self.profile._description;
//
//            });
//        }
//        return nil;
//    }];
//    _intro.text = self.profile._description;
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureProfile:(PROFILEProfile *)profile {
    _intro.text = profile._description;
}

@end


