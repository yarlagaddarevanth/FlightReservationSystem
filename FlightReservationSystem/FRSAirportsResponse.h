//
//  FRSAirportsResponse.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSBaseModel.h"
#import "FRSAirport.h"
#import "FRSResponseModel.h"
@interface FRSAirportsResponse : FRSBaseModel

@property (nonatomic) NSArray<FRSAirport> *airports;

@end
