//
//  FRSViewReservationsResponse.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSResponseModel.h"
#import "FRSReservation.h"

@interface FRSViewReservationsResponse : FRSResponseModel

@property (nonatomic) NSArray<FRSReservation> *reservations;

@end
