#import "AppDelegate.h"

#import <AWSCore/AWSCore.h>
#import <AWSCognito/AWSCognito.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    AWSServiceConfiguration *serviceConfiguration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1
                                                                                credentialsProvider:nil];
    //create a pool
    AWSCognitoIdentityUserPoolConfiguration *configuration = [[AWSCognitoIdentityUserPoolConfiguration alloc]
                                                              initWithClientId:@"295ssmlg44ssu14rhbars4e6l4"
                                                              clientSecret:@"6b0pgdorhgjtc2964c5tqdi7sgq0dgmn5rm6hna3kfv7fsh1uaq"
                                                              poolId:@"us-east-1_qcEjvA6lL"];
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = serviceConfiguration;
    [AWSCognitoIdentityUserPool registerCognitoIdentityUserPoolWithConfiguration:serviceConfiguration
                                                           userPoolConfiguration:configuration
                                                                          forKey:@"UserPool"];
    AWSCognitoIdentityUserPool *pool = [AWSCognitoIdentityUserPool CognitoIdentityUserPoolForKey:@"UserPool"];
    
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    pool.delegate = self;

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//set up password authentication ui to retrieve username and password from the user
- (id<AWSCognitoIdentityPasswordAuthentication>) startPasswordAuthentication {
    
    if (!self.navigationController) {
        self.navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInController"];
    }
    if (!self.signInViewController) {
        self.signInViewController = (ViewController *)self.navigationController.viewControllers[0];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //rewind to login screen
        [self.navigationController popToRootViewControllerAnimated:NO];
        
        //display login screen if it isn't already visibile
        if (!(self.navigationController.isViewLoaded && self.navigationController.view.window))  {
            [self.window.rootViewController presentViewController:self.navigationController animated:YES completion:nil];
        }
    });
    return (id<AWSCognitoIdentityPasswordAuthentication>)self.signInViewController;
}


@end
