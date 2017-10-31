#import <UIKit/UIKit.h>

@class AWSCognitoIdentityUser;
@class AWSCognitoIdentityUserPool;
@class UserSession;

@interface ProfileViewController : UITableViewController

@property (nonatomic, strong) AWSCognitoIdentityUser * user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;

@property (strong, nonatomic) UserSession *userSession;

@end
