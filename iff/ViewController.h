#import <UIKit/UIKit.h>

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface ViewController : UIViewController<AWSCognitoIdentityPasswordAuthentication>

@property (strong, nonatomic) IBOutlet UITextField *userNameField;

@property (strong, nonatomic) IBOutlet UITextField *userPasswordField;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails*>* passwordAuthenticationCompletion;

@end

