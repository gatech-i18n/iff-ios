//
//  DashboardViewController.m
//  iff
//
//  Created by tomoreoreo on 9/8/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "DashboardViewController.h"

#import "NamecardCell.h"
#import "IFFIFFClient.h"
#import "IFFProfile.h"
#import "IFFRecommendation.h"
#import "ProfileViewController.h"

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface DashboardViewController ()
@property (nonatomic,strong) AWSCognitoIdentityUserGetDetailsResponse *response;
@property (nonatomic, strong) AWSCognitoIdentityUser *user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool *pool;
@property (nonatomic, strong) AWSCognitoIdentityUserSession *session;
@property (nonatomic, strong) IFFProfile *recommendationProfile;
@property (nonatomic, strong) UIImageView *bubbleView;

@end

@implementation DashboardViewController {
    BOOL _hasFetched;
}

- (void)viewDidLoad{
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
    [self.namecard removeFromSuperview];
    [self isLoading];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(configureView) userInfo:nil repeats:YES];

    [self refresh];
}

- (void) viewWillAppear:(BOOL)animated {
    self.user = [self.pool currentUser];
}

- (void) isLoading {
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.center = self.view.center;
    [loading startAnimating];
    [self.view addSubview:loading];
}

- (void) configureView {

    if (_hasFetched) {
        if (!_recommendedUsername || _penalty) {
            [self configureBubble];
        } else {
            [self.bubbleView removeFromSuperview];
            [self getRecommendationProfile];
        }
    }
    [self.view reloadInputViews];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"otherprofile"]) {
        
        ProfileViewController *profileVC = (ProfileViewController *)[segue destinationViewController];
        profileVC.profileUsername = _recommendedUsername;
    }
}

- (void)refresh {
    [[self.user getSession] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserSession *> * _Nonnull task) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (task.error) {
                self.title = task.error.userInfo[@"__type"];
                if(self.title == nil){
                    self.title = task.error.userInfo[NSLocalizedDescriptionKey];
                }
                [self.navigationController setToolbarHidden:YES];
            } else {
                self.session = task.result;

                [self.view reloadInputViews];
                [self.navigationController setToolbarHidden:NO];
            }
        });
        
        return nil;
    }];
}

- (IBAction)accept:(id)sender {
    __weak typeof(self) weakSelf = self;
    UIAlertController * alert= [UIAlertController
                                alertControllerWithTitle:@"Congratulations"
                                message:@"You are going to accept the recommendation and have a new friend!"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Accept"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [weakSelf.buttonView setHidden:YES];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    UIAlertAction* cancel = [UIAlertAction
                         actionWithTitle:@"Cancel"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)reject:(id)sender {

    __weak typeof(self) weakSelf = self;
    UIAlertController * alert= [UIAlertController
                                alertControllerWithTitle:@"Warning"
                                message:@"You will need to wait for 24 hours before we can find you another match!"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmReject = [UIAlertAction
                         actionWithTitle:@"Reject"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             _penalty = @"y";
                             [weakSelf configureView];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                         }];
    UIAlertAction* cancel = [UIAlertAction
                                    actionWithTitle:@"Cancel"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
    
    [alert addAction:confirmReject];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)configureBubble {
    NSString *notice;
    if (!_recommendedUsername) {
        notice = @"We are currently looking for a match...";
    } else if (_penalty) {
        notice = @"You have to wait for 24 hours before we search for another match...";
    }
    
    if (!self.bubbleView) {
        UIImage *bubbleIMG = [UIImage imageNamed:@"bubble2"];
        UIImageView *bubble = [[UIImageView alloc] initWithImage:bubbleIMG];
        CGRect myFrame = CGRectMake(0, 150, 375, 310);
        [bubble setFrame:myFrame];
        [self.view addSubview:bubble];
        
        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 60, 179, 95)];
        noticeLabel.text = notice;
        noticeLabel.numberOfLines = 3;
        [bubble addSubview:noticeLabel];
        self.bubbleView = bubble;
    }
}

- (void)getRecommendation:(NSString *)recommendationID {
    IFFIFFClient *profileAPI = [IFFIFFClient defaultClient];
    if (self.session) {
        [[profileAPI recommendationRecommendationIdGet:recommendationID authorization:[self.session.idToken tokenString]] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
            if (!task.error) {
                NSString *userid2 = [(IFFRecommendation *)task.result userId2];
                _hasFetched = YES;
                if (userid2.length > 0) {
                    _recommendedUsername = userid2;
                }
            }

            return nil;
        }];
    }
}

- (void)getRecommendationProfile {
    IFFIFFClient *profileAPI = [IFFIFFClient defaultClient];
    [[profileAPI profileUsernameGet:self.recommendedUsername] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!task.error) {
                self.recommendationProfile = task.result;
                [self configureDetails:self.recommendationProfile];
                [self.view addSubview:self.namecard];
            }
        });

        return nil;
    }];
}

- (void)configureDetails:(IFFProfile *)profile
{
    self.nameLabel.text = profile.fullName;
    self.homeCountryLabel.text = profile.homeCountry;
    self.descriptionLabel.text = profile.reason;
}

@end
