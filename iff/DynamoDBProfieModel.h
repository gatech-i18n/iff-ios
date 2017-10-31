//
//  ConfirmRegistrationViewController.h
//  iff
//
//  Created by Binchen Hu on 10/27/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import <AWSDynamoDB/AWSDynamoDB.h>
#import <Foundation/Foundation.h>

@interface DynamoDBProfileModel : AWSDynamoDBObjectModel <AWSDynamoDBModeling>

@property (nonatomic, strong) NSString *ProfileId;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *FavoriteCountry;
@property (nonatomic, strong) NSArray<NSString *> *FavoriteThings;

@end


