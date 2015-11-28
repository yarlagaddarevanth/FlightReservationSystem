//
//  FRSResponseModel.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/26/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSBaseModel.h"

@interface FRSResponseModel : FRSBaseModel

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSDictionary *message;
@property (nonatomic, strong) NSMutableArray *messagesArray;
@property (nonatomic, strong) NSString *firstMessage;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *status_code;
@property (nonatomic, strong) NSString *errorMessage;

-(BOOL)success;
+(instancetype)defaultAPIFailedResponse;
+(instancetype)defaultServerFailedResponse:(NSString *)error;

@end
