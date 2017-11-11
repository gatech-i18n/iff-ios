#import "ConfirmRegistrationViewController.h"

#import "BasicInfoViewController.h"
#import "RegisterViewController.h"

@interface ConfirmRegistrationViewController ()
@property (strong, nonatomic) IBOutlet UILabel *sentToLabel;
@property (strong, nonatomic) IBOutlet UITextField *codeField;
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;

@end

@implementation ConfirmRegistrationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sentToLabel.text = self.sentTo;
}

#pragma mark - Navigation

- (IBAction)confirm:(id)sender {
    [[self.user confirmSignUp:self.codeField.text forceAliasCreation:YES] continueWithBlock: ^id _Nullable(AWSTask<AWSCognitoIdentityUserConfirmSignUpResponse *> * _Nonnull task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (task.error){
                    UIAlertController * alert= [UIAlertController
                                                alertControllerWithTitle:task.error.userInfo[@"__type"]
                                                message:task.error.userInfo[@"message"]
                                                preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction
                                         actionWithTitle:@"OK"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [alert dismissViewControllerAnimated:YES completion:nil];
                                         }];
                    
                    [alert addAction:ok];
                    
                    [self presentViewController:alert animated:YES completion:nil];
            } else {
//                [[self. user getSession:_username password:_password validationData:nil] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserSession *> * _Nonnull task) {
//                    if (task.error) {
//                        NSLog(@"%@", task.error);
//                    } else {
//                        [self performSegueWithIdentifier:@"BuildProfile" sender:task.result];
//                    }
//                    return nil;
//                }];

                UIAlertController * alert= [UIAlertController
                                            alertControllerWithTitle:@"You have finished!"
                                            message:@"Now you can use your email address and password to sign in!"
                                            preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [self.navigationController popToRootViewControllerAnimated:YES];
                                     }];

                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
        return nil;
    }];
}

- (IBAction)resend:(id)sender {
    [[self.user resendConfirmationCode] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserResendConfirmationCodeResponse *> * _Nonnull task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (task.error) {
                UIAlertController * alert= [UIAlertController
                                            alertControllerWithTitle:task.error.userInfo[@"__type"]
                                            message:task.error.userInfo[@"message"]
                                            preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
                
                [alert addAction:ok];
            } else {
                UIAlertController * notify= [UIAlertController
                                             alertControllerWithTitle:@"Code Resent"
                                             message:[NSString stringWithFormat:@"Code resent to: %@", task.result.codeDeliveryDetails.destination]
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [notify dismissViewControllerAnimated:YES completion:nil];
                                     }];
                
                [notify addAction:ok];
            }
        });
        return nil;
    }];
}

@end
