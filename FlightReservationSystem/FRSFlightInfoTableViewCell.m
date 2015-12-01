//
//  FRSFlightInfoTableViewCell.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSFlightInfoTableViewCell.h"
#import "FRSFlightInfoView.h"

@interface FRSFlightInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet FRSFlightInfoView *flightInfoView;

@end
@implementation FRSFlightInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)configureCellWithFlight:(FRSFlight *)flight{
    [_flightInfoView configureViewWithFlight:flight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
