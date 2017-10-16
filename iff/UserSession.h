//
//  BasicInfoViewController.h
//  iff
//
//  Created by Binchen Hu on 9/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject

@property (strong, nonatomic, readonly) NSString *userID;

@property (strong, nonatomic, readonly) NSString *profileID;

@property (strong, nonatomic) NSString *email;

@property (strong, nonatomic) NSString *firstName;

@property (strong, nonatomic) NSString *lastName;

@property (strong, nonatomic) NSString *country;

@property (strong, nonatomic) NSURL *profileImage;

@property (strong, nonatomic) NSString *favoriteCountry;

@property (strong, nonatomic) NSArray<NSString *> *favoriteThings;

@property (strong, nonatomic) NSString *more;

- (UserSession *)initWithUserID:(NSString *)userID;

- (UserSession *)initWithProfileID:(NSString *)profileID
                             email:(NSString *)email
                         firstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                           country:(NSString *)country
                    favoriteThings:(NSArray<NSString *> *)favoriteThings
                              more:(NSString *)more;

@end

