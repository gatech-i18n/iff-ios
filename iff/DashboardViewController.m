//
//  DashboardViewController.m
//  iff
//
//  Created by tomoreoreo on 9/8/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "DashboardViewController.h"

#import "NamecardCell.h"
#import "PROFILEProfile.h"
#import "PROFILEIFFClient.h"
#import "ProfileViewController.h"

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@interface DashboardViewController ()
@property (nonatomic,strong) AWSCognitoIdentityUserGetDetailsResponse * response;
@property (nonatomic, strong) AWSCognitoIdentityUser * user;
@property (nonatomic, strong) AWSCognitoIdentityUserPool * pool;
@end

@implementation DashboardViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    //on initial load set the user and refresh to get attributes
    if (!self.user) {
        self.user = [self.pool currentUser];
    }
    self.recommendedUsername = @"abc123";
    [self refresh];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.recommendedUsername = @"abc123";
    [self.navigationController setToolbarHidden:YES];
    [self configureView];
}

- (void) configureView {
    if (!_recommendedUsername || _penalty) {
        [self.namecard setHidden:YES];
        [self configureBubble];
    }
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
        
//        PROFILEIFFClient *profileAPI = [PROFILEIFFClient defaultClient];
        ProfileViewController *profileVC = (ProfileViewController *)[segue destinationViewController];
        profileVC.profileUsername = @"abc123";
//        [[profileAPI profileUsernameGet:@"abc123"] continueWithBlock:^id _Nullable(AWSTask * _Nonnull task) {
//            if (task.error) {
//                UIAlertController * alert=   [UIAlertController
//                                              alertControllerWithTitle:task.error.userInfo[@"x-cache"]
//                                              message:task.error.userInfo[@"x-amzn-errortype"]
//                                              preferredStyle:UIAlertControllerStyleAlert];
//
//                UIAlertAction* ok = [UIAlertAction
//                                     actionWithTitle:@"OK"
//                                     style:UIAlertActionStyleDefault
//                                     handler:^(UIAlertAction * action)
//                                     {
//                                         [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                                     }];
//
//                [alert addAction:ok];
//
//                [self presentViewController:alert animated:YES completion:nil];
//            } else {
//                PROFILEProfile *profile = task.result;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [profileVC configureProfile:profile];
//                });
//            }
//            return nil;
//        }];
    }
}

- (void)refresh {
    [[self.user getDetails] continueWithBlock:^id _Nullable(AWSTask<AWSCognitoIdentityUserGetDetailsResponse *> * _Nonnull task) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (task.error) {
                self.title = task.error.userInfo[@"__type"];
                if(self.title == nil){
                    self.title = task.error.userInfo[NSLocalizedDescriptionKey];
                }
                [self.navigationController setToolbarHidden:YES];
            } else {
                self.response = task.result;
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
                                message:@"You will need to wait for 3 days before we can find you another match!"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmReject = [UIAlertAction
                         actionWithTitle:@"Reject"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             weakSelf.penalty = @"3";
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
        notice = @"You have to wait for 3 days before we search for another match...";
    }
    
    UIImage *bubbleIMG = [UIImage imageNamed:@"bubble2"];
    UIImageView *bubble = [[UIImageView alloc] initWithImage:bubbleIMG];
    CGRect myFrame = CGRectMake(0, 150, 375, 310);
    [bubble setFrame:myFrame];
    [self.view addSubview:bubble];
    
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 210, 179, 95)];
    noticeLabel.text = notice;
    noticeLabel.numberOfLines = 3;
    [self.view addSubview:noticeLabel];
}

@end
