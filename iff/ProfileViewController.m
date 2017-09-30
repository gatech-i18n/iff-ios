
#import "ProfileViewController.h"

#import "UserSession.h"

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _userSession = [[UserSession alloc] initWithEmail:@"burdell@gatech.edu" firstName:@"George" lastName:@"Burdell" country:@"United States" favoriteThings:@[@"buzz", @"chickfila", @"basketball"] more:@"I love GT!"];
    
    _username.text = _userSession.firstName;
    _useremail.text = _userSession.email;
    _country.text = _userSession.country;
    
    _item1.text = _userSession.favoriteThings[0];
    _item2.text = _userSession.favoriteThings[1];
    _item3.text = _userSession.favoriteThings[2];
    
    _selfDescription.text = _userSession.more;
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 210, self.view.frame.size.width, self.view.frame.size.height-210)];
//    [self.view addSubview:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


