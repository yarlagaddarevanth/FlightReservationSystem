//
//  FRSCard.h
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 12/16/16.
//  Copyright © 2016 Revanth Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRSCard : NSObject

@property(nonatomic, strong) NSString *contents;

+ (int)getCount:(NSArray *)otherCards;

- (int)match:(NSArray *)otherCards;
- (int)numberOfMatches:(NSArray *)otherCards;

@end
