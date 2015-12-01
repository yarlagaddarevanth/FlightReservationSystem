//
//  FRSAvailableFlightsListViewController.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSBaseViewController.h"

@interface FRSAvailableFlightsListViewController : FRSBaseViewController

@property (nonatomic) FRSReservation *reservation;
@property (nonatomic) NSArray *flightsArray;

@end
