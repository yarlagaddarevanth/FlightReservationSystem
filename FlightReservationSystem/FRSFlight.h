//
//  FRSFlight.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSBaseModel.h"

@protocol FRSFlight

@end

@interface FRSFlight : FRSBaseModel

@property (nonatomic) NSString *flightDbId;
@property (nonatomic) NSString *flightId;
@property (nonatomic) NSString *destinationCode;
@property (nonatomic) NSString *destination;
@property (nonatomic) NSString *sourceCode;
@property (nonatomic) NSString *source;
@property (nonatomic) NSString *noOfSeats;
@property (nonatomic) NSString *noOfSeatsAvailable;
@property (nonatomic) NSString *departure;
@property (nonatomic) NSString *flightCode;
@property (nonatomic) NSString *arrival;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *departureTime;
@property (nonatomic) NSString *arrivalTime;


/*
 
 id: 25
 flightId: "2"
 destinationCode: "SNF"
 destination: "San Franscio USA"
 sourceCode: "BLR"
 source: "Bangalore India"
 noOfSeats: 140
 noOfSeatsAvailable: 130
 departure: 1388618936782
 arrival: 1388618936782
 price: 136
 departureTime: "01-01-2014 17:28:56"
 arrivalTime: "01-01-2014 17:28:56"

 */
@end
