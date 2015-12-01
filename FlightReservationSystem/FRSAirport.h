//
//  FRSDestination.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSBaseModel.h"
@protocol FRSAirport
@end

@interface FRSAirport : FRSBaseModel

@property (nonatomic) NSString *airportId;
@property (nonatomic) NSString *airportCode;
@property (nonatomic) NSString *airportName;
@property (nonatomic) NSString *country;

@end
