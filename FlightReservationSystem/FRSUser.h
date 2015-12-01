//
//  FRSUser.h
//  FlightReservationSystem
//
//  Created by Revanth on 11/03/15.
//  Copyright (c) 2015 Revanth. All rights reserved.
//

#import "FRSBaseModel.h"
#import "FRSLoginResponse.h"

#define USER_ROLE_ADMIN @"admin"
#define USER_ROLE_GUEST @"guest"
#define USER_ROLE_USER @"user"

@interface FRSUser : FRSBaseModel

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;

-(NSString *)fullName;

@end
