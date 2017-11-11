#import <UIKit/UIKit.h>

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@class UserProfile;

@interface ConfirmRegistrationViewController : UIViewController

@property (nonatomic, strong) AWSCognitoIdentityUser *user;
@property (nonatomic, strong) NSString *sentTo;
@property (nonatomic, strong) UserProfile *userProfile;

@end
