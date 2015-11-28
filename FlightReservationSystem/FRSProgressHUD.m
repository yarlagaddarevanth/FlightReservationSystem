//
//  FRSProgressHUD.m
//  FlightReservationSystem
//
//  Created by Revanth on 11/05/15.
//  Copyright (c) 2015 Revanth. All rights reserved.
//

#import "FRSProgressHUD.h"

@implementation FRSProgressHUD

- (id)initWithView:(UIView *)view showAnimated:(BOOL)animated{
    if (self = [super initWithView:view]) {
        [view addSubview:self];
        [self show:animated];
    }
    
    return self;
}

@end
