#import <UIKit/UIKit.h>

#import "IFFProfile.h"

@class AWSCognitoIdentityUser;
@class AWSCognitoIdentityUserPool;
@class UserSession;

@interface ProfileViewController : UITableViewController

@property (nonatomic, strong) AWSCognitoIdentityUser * user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;

@property (strong, nonatomic) UserSession *userSession;
@property (strong, nonatomic) NSString *profileUsername;

@property (strong, nonatomic) IBOutlet UILabel *interests;

@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) IBOutlet UILabel *homeCountry;
@property (strong, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet UILabel *country1;
@property (weak, nonatomic) IBOutlet UILabel *country2;
@property (weak, nonatomic) IBOutlet UIImageView *gender;

- (void)configureProfile:(IFFProfile *)profile;
@end
