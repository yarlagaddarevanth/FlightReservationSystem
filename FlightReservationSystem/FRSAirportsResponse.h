//
//  FRSAirportsResponse.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSAirport.h"
#import "FRSResponseModel.h"
@interface FRSAirportsResponse : FRSResponseModel

@property (nonatomic) NSArray<FRSAirport> *airports;

@end
