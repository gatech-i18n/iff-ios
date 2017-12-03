#import "ViewController.h"

#import "IFFIFFClient.h"
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProviderService.h>

@implementation ViewController {
    BOOL _hasProfile;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleLogin:(id)sender {
    IFFIFFClient *profileAPI = [IFFIFFClient defaultClient];
    [[profileAPI profileUsernameGet:self.userNameField.text] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
        if (!task.error) {
            IFFProfile *profile = task.result;
            if (profile.fullName.length > 0) {
                _hasProfile = YES;
            }
        }
        return nil;
    }];
    self.passwordAuthenticationCompletion.result = [[AWSCognitoIdentityPasswordAuthenticationDetails alloc] initWithUsername:self.userNameField.text password:self.userPasswordField.text];
    
}

# pragma AWSCognitoIdentityPasswordAuthentication

- (void) getPasswordAuthenticationDetails:(AWSCognitoIdentityPasswordAuthenticationInput *)authenticationInput passwordAuthenticationCompletionSource:(AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails *> *)passwordAuthenticationCompletionSource
{
    self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.userNameField.text) {
            self.userNameField.text = authenticationInput.lastKnownUsername;
        }
    });
}

- (void) didCompletePasswordAuthenticationStepWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error) {
            UIAlertController * alert= [UIAlertController
                                        alertControllerWithTitle:error.userInfo[@"__type"]
                                        message:error.userInfo[@"message"]
                                        preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* retry = [UIAlertAction
                                    actionWithTitle:@"Retry"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                     
                                    }];
            
            [alert addAction:retry];

            [self presentViewController:alert animated:YES completion:nil];
        } else {
            if (_hasProfile) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self performSegueWithIdentifier:@"AddInfo" sender:nil];
            }
        }
    });
}

@end
