#import <UIKit/UIKit.h>

#import "PROFILEProfile.h"

@class AWSCognitoIdentityUser;
@class AWSCognitoIdentityUserPool;
@class UserSession;

@interface ProfileViewController : UITableViewController

@property (nonatomic, strong) AWSCognitoIdentityUser * user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;

@property (strong, nonatomic) UserSession *userSession;
@property (strong, nonatomic) NSString *profileUsername;

@property (strong, nonatomic) IBOutlet UILabel *interest1;
@property (strong, nonatomic) IBOutlet UILabel *interest2;
@property (strong, nonatomic) IBOutlet UILabel *interest3;

@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *country;
@property (strong, nonatomic) IBOutlet UILabel *intro;

- (void)configureProfile:(PROFILEProfile *)profile;
@end
