//
//  FRSViewReservationTableViewCell.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRSReservation.h"

@interface FRSViewReservationTableViewCell : UITableViewCell

-(void)configureCellWithReservation:(FRSReservation *)reservation;
@end
