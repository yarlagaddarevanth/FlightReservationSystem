//
//  FRSFlight.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/28/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSFlight.h"

@implementation FRSFlight

-(NSString *)displayDepartureDateStr{
    NSString *str = @"";
    if(_departureTime.isValid) {
        if ([_departureTime componentsSeparatedByString:@" "].count > 0) {
          str = [_departureTime componentsSeparatedByString:@" "][0];
        }
    }
    else if (_departure.isValid) {
        NSString * timeStampString = _departure;
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval/1000];
        NSLog(@"%@", date);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        str = [dateFormatter stringFromDate:date];
        
    }


    return str;
}
-(NSString *)displayDepartureTimeStr{
    NSString *str;
    if(_departureTime.isValid) {
        if ([_departureTime componentsSeparatedByString:@" "].count == 2 ) {
            str = [_departureTime componentsSeparatedByString:@" "][1];
        }
    }
    else if (_departure) {
        NSString * timeStampString = _departure;
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval/1000];
        NSLog(@"%@", date);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH-mm"];
        str = [dateFormatter stringFromDate:date];
        
    }

    return str;
}
-(NSString *)displayArrivalDateStr{
    NSString *str = @"";
    if(_arrivalTime.isValid) {
        if ([_arrivalTime componentsSeparatedByString:@" "].count > 0) {
            str = [_arrivalTime componentsSeparatedByString:@" "][0];
        }
    }
    else if (_arrival.isValid) {
        NSString * timeStampString = _arrival;
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval/1000];
        NSLog(@"%@", date);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        str = [dateFormatter stringFromDate:date];
        
    }
    
    return str;
 
}
-(NSString *)displayArrivalTimeStr{
    NSString *str;
    if(_arrivalTime.isValid) {
        if ([_arrivalTime componentsSeparatedByString:@" "].count == 2 ) {
            str = [_arrivalTime componentsSeparatedByString:@" "][1];
        }
    }
    else if (_arrival) {
        NSString * timeStampString = _arrival;
        NSTimeInterval _interval=[timeStampString doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval/1000];
        NSLog(@"%@", date);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH-mm"];
        str = [dateFormatter stringFromDate:date];
        
    }
    
    return str;

}

@end
