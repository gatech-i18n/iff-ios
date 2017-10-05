#import <UIKit/UIKit.h>

@class AWSCognitoIdentityUser;
@class AWSCognitoIdentityUserPool;
@class UserSession;

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) AWSCognitoIdentityUser * user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;

@property (strong, nonatomic) UserSession *userSession;

@property (strong, nonatomic) IBOutlet UILabel *useremail;
@property (strong, nonatomic) IBOutlet UILabel *country;

@property (strong, nonatomic) IBOutlet UILabel *item1;
@property (strong, nonatomic) IBOutlet UILabel *item2;
@property (strong, nonatomic) IBOutlet UILabel *item3;

@property (strong, nonatomic) IBOutlet UITextView *selfDescription;

@end
