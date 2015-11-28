//
//  FRSLoginResponse.h
//  FlightReservationSystem
//
//  Created by Revanth on 11/05/15.
//  Copyright (c) 2015 Revanth. All rights reserved.
//

#import "FRSBaseModel.h"
@class FRSUser;

@interface FRSLoginResponse : FRSBaseModel
@property (nonatomic) NSString *authentication;
//@property (nonatomic) NSString *access_token;
//@property (nonatomic) NSString *expires_in;
//@property (nonatomic) NSString *refresh_token;
//@property (nonatomic) NSString *token_type;

@property (nonatomic) FRSUser *user;

@end
