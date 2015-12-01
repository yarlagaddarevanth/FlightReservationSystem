//
//  FRSFlightInfoTableViewCell.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRSFlight.h"

@interface FRSFlightInfoTableViewCell : UITableViewCell
-(void)configureCellWithFlight:(FRSFlight *)flight;
@end
