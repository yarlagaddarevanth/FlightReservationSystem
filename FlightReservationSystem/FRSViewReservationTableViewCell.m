//
//  FRSViewReservationTableViewCell.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/1/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSViewReservationTableViewCell.h"
@interface FRSViewReservationTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *reservationID;
@property (weak, nonatomic) IBOutlet UILabel *passengers;

@end

@implementation FRSViewReservationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)configureCellWithReservation:(FRSReservation *)reservation{
    _reservationID.text = [NSString stringWithFormat:@"reservation: %@",reservation.reservationId];
    _passengers.text = [NSString stringWithFormat:@"Passengers: %@",reservation.passengers];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
