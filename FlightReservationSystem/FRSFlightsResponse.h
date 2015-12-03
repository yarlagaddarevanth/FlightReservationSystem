//
//  FRSSearchFlightsResponse.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSResponseModel.h"
#import "FRSFlight.h"

@interface FRSFlightsResponse : FRSResponseModel

@property (nonatomic) NSArray<FRSFlight> *flights;

@end
