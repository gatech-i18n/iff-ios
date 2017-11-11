#import <UIKit/UIKit.h>

#import <AWSCognitoIdentityProvider/AWSCognitoIdentityProvider.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, AWSCognitoIdentityInteractiveAuthenticationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIStoryboard *storyboard;
@property(nonatomic,strong) UINavigationController *navigationController;
@property(nonatomic,strong) ViewController* signInViewController;

@end

