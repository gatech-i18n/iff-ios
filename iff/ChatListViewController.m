#import "ChatListViewController.h"

#import "IFFIFFClient.h"
#import "IFFProfile.h"
#import "IFFRecommendation.h"

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface ChatListViewController ()

@property (nonatomic, strong) NSString *recommendedUsername;
@property (nonatomic, strong) AWSCognitoIdentityUserSession *session;
@property (nonatomic, strong) AWSCognitoIdentityUser *user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool *pool;
@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    //on initial load set the user and refresh to get attributes
    self.user = [self.pool currentUser];
    [[self.user getSession] continueWithSuccessBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserSession *> * _Nonnull task) {
        if (task.error) {
            NSLog(@"%@", task.error);
        } else {
            self.session = task.result;
        }
        return nil;
    }];
    if ([self.user.username isEqualToString:@"iwannabxm"]) {
        [self getRecommendationByID:@"test_id"];
    }
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(configureChat) userInfo:nil repeats:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    self.user = [self.pool currentUser];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureChat {
    if ([self.user.username isEqualToString:@"haha233"]) {
        [self getRecommendationByID:@"test_id"];
    }
    if (self.recommendedUsername) {
        [self getRecommendationProfile];
    }
    [self.view reloadInputViews];
}

- (void)getRecommendationByID:(NSString *)rec_id {
    IFFIFFClient *profileAPI = [IFFIFFClient defaultClient];
    [[profileAPI recommendationRecommendationIdGet:rec_id authorization:[self.session.idToken tokenString]] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
        if (!task.error) {
            NSString *userid2 = [(IFFRecommendation *)task.result userId2];
            if (userid2.length > 0) {
                self.recommendedUsername = userid2;
            }
        }
        return nil;
    }];
}

- (void)getRecommendationProfile {
    IFFIFFClient *profileAPI = [IFFIFFClient defaultClient];
    [[profileAPI profileUsernameGet:self.recommendedUsername] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!task.error) {
                IFFProfile *profile = (IFFProfile *)task.result;
                self.chatName.text = profile.fullName;
            }
        });
        
        return nil;
    }];
}

@end
