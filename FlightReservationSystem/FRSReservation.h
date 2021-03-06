//
//  FRSReservation.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSBaseModel.h"
#import "FRSFlight.h"
#import "FRSAirport.h"

@protocol FRSReservation
@end

@interface FRSReservation : FRSBaseModel

@property (nonatomic) FRSFlight *flight;
@property (nonatomic) FRSAirport *fromAirport;
@property (nonatomic) FRSAirport *toAirport;
@property (nonatomic) NSString *reservationId;
@property (nonatomic) NSString *flightCode;
@property (nonatomic) NSString *flightId;
@property (nonatomic) NSString *userId;

@property (nonatomic) NSInteger noOfPassengers;
@property (nonatomic) NSString *passengers;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *mobileNumber;
@property (nonatomic) NSString *source;
@property (nonatomic) NSString *destination;
@property (nonatomic) NSString *price;
@property (nonatomic) NSDate *dateOfJourney;

/*
"flightId": 27,
"flightCode": "UCM1436",
"noOfPassengers": 3,
"passengers": "seenu,siva,revanth,dinesh",
"address": "oak street",
"mobileNumber": "+181623456789"
*/
@end
