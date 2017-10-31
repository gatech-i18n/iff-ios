//
//  UserSession.m
//  iff
//
//  Created by Binchen Hu on 9/30/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

- (UserProfile *)initWithUserID:(NSString *) userID
{
    self = [super init];
    if (self) {
        _userID = userID;
    }
    
    return self;
}

- (UserProfile *)initWithProfileID:(NSString *)profileID
                             email:(NSString *)email
                         firstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                           country:(NSString *)country
                    favoriteThings:(NSArray<NSString *> *)favoriteThings
                              more:(NSString *)more
{
    self = [super init];
    if (self) {
        _profileID = profileID;
        _email = email;
        _firstName = firstName;
        _lastName = lastName;
        _country = country;
        _favoriteThings = favoriteThings;
        _more = more;
    }
    
    return self;
}

@end
