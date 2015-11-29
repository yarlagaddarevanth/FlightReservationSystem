//
//  FRSFlightInfoView.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSFlightInfoView.h"

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

@end
