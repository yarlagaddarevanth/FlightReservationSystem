//
//  FRSViewReservationTableViewCell.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSViewReservationTableViewCell.h"
@interface FRSViewReservationTableViewCell ()

@end

@implementation FRSViewReservationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)configureCellWithReservation:(FRSReservation *)reservation{
    self.textLabel.text = [NSString stringWithFormat:@"Res: %@",reservation.reservationId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
