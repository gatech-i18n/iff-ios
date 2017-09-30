#import <UIKit/UIKit.h>

@class UserSession;

@interface ProfileViewController : UIViewController

@property (strong, atomic) UserSession *userSession;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *useremail;
@property (strong, nonatomic) IBOutlet UILabel *country;

@property (strong, nonatomic) IBOutlet UILabel *item1;
@property (strong, nonatomic) IBOutlet UILabel *item2;
@property (strong, nonatomic) IBOutlet UILabel *item3;

@property (strong, nonatomic) IBOutlet UITextView *selfDescription;

@end
