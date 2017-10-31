//
//  DynamoDBProfileModel.m
//  iff
//
//  Created by Binchen Hu on 10/28/17.
//  Copyright © 2017 tomoreoreo. All rights reserved.
//

#import "DynamoDBProfieModel.h"

@implementation DynamoDBProfileModel

+ (NSString *)dynamoDBTableName {
    return @"Profile";
}

+ (NSString *)hashKeyAttribute {
    return @"ProfileId";
}

@end
