//
//  FRSFlightInfoView.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSFlightInfoView.h"

@interface FRSFlightInfoView ()
@property (weak, nonatomic) IBOutlet UILabel *flightNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;

@end

@implementation FRSFlightInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self load];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self load];
    }
    return self;
}

-(void)load{
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FRSFlightInfoView class])
                                                  owner:self
                                                options:nil]
                    firstObject];
    [self addSubview:view];
    view.frame = self.bounds;
    
}

-(void)configureViewWithFlight:(FRSFlight *)flight{
    _flightNameLabel.text = [NSString stringWithFormat:@"Name: %@",flight.flightCode];
    _dateLabel.text = [NSString stringWithFormat:@"Date: %@",flight.departureTime];
    _timeLabel.text = [NSString stringWithFormat:@"Time: %@",flight.departureTime];
    _fromLabel.text = flight.source;
    _toLabel.text = flight.destination;
}


@end
