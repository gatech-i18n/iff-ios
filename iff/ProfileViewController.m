
#import "ProfileViewController.h"

#import "UserSession.h"
#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    if (!self.user) {
        self.user = [self.pool currentUser];
    }
    
    _userSession = [[UserSession alloc] initWithProfileID:[[NSUUID UUID] UUIDString] email:@"burdell@gatech.edu" firstName:@"George" lastName:@"Burdell" country:@"China" favoriteThings:@[@"buzz", @"chickfila", @"basketball"] more:@"I love GT!"];
    
    _useremail.text = self.user.username;
    _country.text = _userSession.country;
    
    _item1.text = _userSession.favoriteThings[0];
    _item2.text = _userSession.favoriteThings[1];
    _item3.text = _userSession.favoriteThings[2];
    
    _selfDescription.text = _userSession.more;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


