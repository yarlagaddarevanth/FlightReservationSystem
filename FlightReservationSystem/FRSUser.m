//
//  FRSUser.m
//  FlightReservationSystem
//
//  Created by Revanth on 11/03/15.
//  Copyright (c) 2015 Revanth. All rights reserved.
//

#import "FRSUser.h"

@implementation FRSUser

-(NSString *)fullName{
    return [NSString stringWithFormat:@"%@ %@",_firstName,_lastName];
}


@end
